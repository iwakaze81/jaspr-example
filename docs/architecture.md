# アーキテクチャ設計

## 全体構成

```
┌─────────────────────────────────────────────────────────────┐
│  GitHub Pages: https://<user>.github.io/jaspr-example/     │
│                                                             │
│  /              → Jaspr LP (lp/)                           │
│  /app/          → Flutter Web App (flutter_app/)           │
└─────────────────────────────────────────────────────────────┘
```

2 つのプロジェクトは独立してビルドされ、GitHub Actions で 1 つの静的サイトとして統合されます。

---

## lp/ — Jaspr ランディングページ

### レンダリングモード: Static SSG

```sh
dart run jaspr_cli:jaspr build   # → lp/build/jaspr/ に完全な HTML を生成
```

サーバー不要・CDN でそのままホスティング可能。SEO に強い。

### コンポーネント構成

```
lib/
├── components/
│   ├── ui/                            # 汎用コンポーネント
│   │   ├── button.dart                # Primary / Secondary
│   │   ├── badge.dart
│   │   └── section_wrapper.dart       # max-width + padding の統一
│   ├── layout/
│   │   ├── navbar.dart                # スクロール検知（JS Interop）
│   │   └── footer.dart
│   └── sections/
│       ├── hero_section.dart
│       ├── features_section.dart
│       ├── flutter_demo_section.dart  # ★ FlutterView 埋め込み
│       ├── platform_section.dart
│       ├── testimonials_section.dart
│       └── cta_section.dart
├── styles/
│   └── theme.dart                     # 色定数（CSS-in-Dart）
├── pages/
│   └── home_page.dart
├── widgets/
│   └── feed_preview.dart              # Flutter Widget（Web 専用）
├── app.dart                           # ルート @client Component
├── main.server.dart                   # SSG エントリ（ビルド時に実行）
└── main.client.dart                   # ブラウザ Hydration エントリ
```

### FlutterView 埋め込み（jaspr_flutter_embed）

LP の「Live Demo」セクションで Flutter ウィジェットを直接レンダリングする。

```
HTML (Jaspr)
└── <div class="demo-section__embed">
    └── FlutterEmbedView.deferred(builder: () => FeedPreviewWidget())
        └── <flutter-view>  ← Flutter がここに描画
```

- `@Import.onWeb` アノテーションで Web 専用の deferred import を定義
- `jaspr_builder` が `*.imports.dart` を自動生成
- `FlutterEmbedView.deferred` は画面内に入るまで Flutter を初期化しない（FCP 保護）

---

## flutter_app/ — Flutter Web SNS アプリ

### ビルド

```sh
flutter build web --base-href /app/
# → flutter_app/build/web/ に出力
```

### 構成方針

LP とは完全に独立したプロジェクト。LP の「Get Started」ボタンから遷移する先。
`/app/` を直接開いても動作する。

---

## デプロイフロー

本番と PR プレビューを同じ `gh-pages` ブランチに同居させる。
本番は root に、PR プレビューは `pr-preview/pr-N/` サブディレクトリに配置する。

### 本番（main への push）

```
main ブランチへの push
        │
        ▼
┌─────────────────────────────────┐
│ deploy.yml (build-and-deploy)   │
│                                 │
│ 1. Flutter Web ビルド           │ → flutter_app/build/web/
│ 2. Jaspr LP ビルド              │ → lp/build/jaspr/
│    --dart-define=BASE_HREF=...  │   ← サブパスを注入
│ 3. dist/ にマージ               │
│    dist/        ← LP            │
│    dist/app/    ← Flutter       │
│ 4. JamesIves/github-pages-      │
│    deploy-action                │
│    branch: gh-pages             │
│    folder: dist                 │
│    clean-exclude: pr-preview    │ ← PR プレビューを保持
└─────────────────────────────────┘
        │
        ▼
gh-pages ブランチ root を Pages が公開
```

### PR プレビュー（PR への push）

```
PR open / synchronize / reopen
        │
        ▼
┌─────────────────────────────────┐
│ preview.yml (preview)           │
│                                 │
│ 1. Jaspr LP のみビルド          │ → lp/build/jaspr/
│    --dart-define=BASE_HREF=     │
│      /jaspr-example/            │
│      pr-preview/pr-N/           │
│ 2. rossjrw/pr-preview-action    │
│    preview-branch: gh-pages     │
│    umbrella-dir: pr-preview     │
└─────────────────────────────────┘
        │
        ▼
gh-pages の pr-preview/pr-N/ に
LP がデプロイされ PR にコメント

PR が close されると pr-preview/pr-N/ は自動削除
```

> **GitHub Pages の Source 設定**: Settings → Pages → Source を **Deploy from a branch** にし、Branch を `gh-pages` / `(root)` に設定する。

---

## GitHub Pages デプロイの注意点

実装中にハマったポイントをまとめる。

### 1. `<base href>` とスクリプトパスの不一致

**症状**: `flutter_bootstrap.js` と `main.client.dart.js` が 404 になり Flutter が起動しない。

**原因**: Jaspr の `Document` コンポーネントは `<base href="/">` をデフォルトで出力する。
GitHub Pages のサブパス（例: `/jaspr-example/`）に配置すると、相対パスがルートから解決されてしまいファイルが見つからない。

**解決**: `Document` の `base` パラメータに `--dart-define` で注入したパスを渡す。

```dart
// main.server.dart
const base = String.fromEnvironment('BASE_HREF', defaultValue: '/');
runApp(Document(base: base, ...));
```

```yaml
# deploy.yml
run: dart run jaspr_cli:jaspr build --dart-define=BASE_HREF=/jaspr-example/
```

ルートドメインに配置する場合（カスタムドメイン、`username.github.io` リポジトリ）は `--dart-define` 不要。

---

### 2. FlutterEmbedView に明示的な `height` が必要

**症状**: `flutter-view` の高さが 0px になり Flutter の描画が行われない。

**原因**: `FlutterEmbedView` の内部実装は `div(styles: Styles(height: 100.percent))` で描画領域を確保する。
CSS の仕様上、`height: 100%` は親の `height` プロパティを参照し、`min-height` のみでは 0 に解決される。

**解決**: `FlutterEmbedView` の `styles` と `constraints` に明示的な高さを設定する。

```dart
FlutterEmbedView.deferred(
  styles: Styles(height: 580.px),          // ← 必須
  constraints: ViewConstraints(
    minWidth: 320,
    minHeight: 580,
    maxWidth: 400,
    maxHeight: 580,                        // ← double.infinity にしない
  ),
  ...
)
```

---

### 3. `jaspr serve`（開発モード）では Flutter Embed は動作しない

**原因**: 開発モードは DDC（Dart Development Compiler）を使用するが、DDC は Flutter の platform SDK 依存を含むライブラリをスキップする。

**Flutter Embed の動作確認は `jaspr build` + ローカルサーバーで行う**:

```sh
dart run jaspr_cli:jaspr build
cd build/jaspr
python3 -m http.server 8081
# http://localhost:8081/ をブラウザで確認
```

---

### 4. GitHub Pages はカスタム HTTP ヘッダーを設定できない

Flutter Web の Skwasm レンダラーは `SharedArrayBuffer` を使用するため、
`Cross-Origin-Opener-Policy: same-origin` と `Cross-Origin-Embedder-Policy: require-corp` ヘッダーが必要。
GitHub Pages はこれらのヘッダーを設定できない。

ただし Flutter は自動的に CanvasKit（または `skwasm_heavy`）にフォールバックするため、
**実用上は問題なく動作する**（Skwasm の最大パフォーマンスは得られない）。

---

## Jaspr 0.23.x API メモ

Jaspr の CSS-in-Dart API は直感的でない部分があるため記録する。

| やりたいこと | 正しい書き方 | 誤りやすい書き方 |
|---|---|---|
| gap 指定 | `gap: Gap(row: 1.rem, column: 1.rem)` | `gap: 1.rem` |
| border radius | `radius: BorderRadius.circular(1.rem)` | `borderRadius: ...` |
| margin (一辺) | `margin: Margin.only(bottom: 1.rem)` | `marginBottom: 1.rem` |
| line height | `lineHeight: Unit.expression('1.7')` | `lineHeight: 1.7` |
| align items | `alignItems: .start` | `alignItems: .flexStart` |
| background | `backgroundColor: Color('#hex')` または `raw: {'background': '...'}` | `background: ...` |
| media query | `css.media(MediaQuery.raw('(max-width: 768px)'), [...])` | `css('@media ...', [...])` |
| fixed 配置 | `position: Position.fixed(top: Unit.zero, left: Unit.zero)` | `position: .fixed` + 別途 `top:` |
| テキスト | `Component.text('...')` | `text('...')` (deprecated) |
| @css 制約 | public クラス・static メンバのみ | private クラスや `_` 付きメンバは不可 |

---

## パフォーマンス目標

| 指標 | 目標 |
|---|---|
| LP Lighthouse Performance | 90+ |
| LP First Contentful Paint | < 1.5s |
| LP Total Blocking Time | < 200ms |
| Flutter Web 初期ロード | < 3s |

LP の FlutterEmbedView は `FlutterEmbedView.deferred` による遅延ロードで LP 全体の初期パフォーマンスを保護している。
