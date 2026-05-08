# アーキテクチャ設計

## 全体構成

```
┌─────────────────────────────────────────────────────────────┐
│  GitHub Pages: https://<user>.github.io/jaspr-example/     │
│                                                             │
│  /          → Jaspr LP (lp/)                               │
│  /app/      → Flutter Web App (flutter_app/)               │
└─────────────────────────────────────────────────────────────┘
```

2 つのプロジェクトは独立してビルドされ、GitHub Actions で 1 つの静的サイトとして統合されます。

---

## lp/ — Jaspr ランディングページ

### レンダリングモード: Static SSG

```sh
dart run jaspr build   # → lp/build/web/ に完全な HTML を生成
```

サーバー不要・CDN でそのままホスティング可能。SEO に強い。

### コンポーネント構成

```
lib/
├── components/
│   ├── ui/                        # 汎用コンポーネント
│   │   ├── button.dart            # Primary / Secondary / Ghost
│   │   ├── card.dart
│   │   ├── badge.dart
│   │   └── section_wrapper.dart   # max-width + padding の統一
│   ├── layout/
│   │   ├── navbar.dart            # スクロール検知（JS Interop）
│   │   └── footer.dart
│   └── sections/
│       ├── hero_section.dart
│       ├── features_section.dart
│       ├── flutter_demo_section.dart   # ★ FlutterView 埋め込み
│       ├── platform_section.dart
│       ├── testimonials_section.dart
│       └── cta_section.dart
├── styles/
│   ├── theme.dart          # CSS Custom Properties（ダーク/ライト）
│   ├── typography.dart
│   ├── breakpoints.dart    # メディアクエリ定数
│   └── animations.dart     # @keyframes 定義
├── pages/
│   └── home_page.dart
├── app.dart                # ルート Component + グローバルスタイル登録
└── main.dart
```

### スタイリング戦略

Jaspr の `StyleSheet` API で CSS-in-Dart を採用。

```dart
// styles/theme.dart — CSS変数でトークン管理
css(':root', [
  Rule.property('--color-primary', '#6366f1'),
  Rule.property('--color-bg', '#ffffff'),
]);
css('[data-theme="dark"]', [
  Rule.property('--color-bg', '#0f0f0f'),
]);
```

コンポーネントごとにスコープされたクラス名を使用し、グローバル汚染を防ぐ。

### FlutterView 埋め込み（jaspr_flutter_embed）

LP の「Try it live」セクションでは Flutter ウィジェットをそのままレンダリングする。

```
HTML (Jaspr)
└── <div class="flutter-demo">
    └── FlutterView(target: FeedPreviewApp)  ← Flutter canvas
```

`lp/pubspec.yaml` に `jaspr_flutter_embed` を追加し、  
`lp/lib/flutter/feed_preview.dart` に Flutter の `Widget` を定義する。  
同一 Dart プロジェクト内でビルドされるため、追加のサーバーは不要。

> **注意**: `jaspr_flutter_embed` を使うと Flutter の JS ランタイムが含まれるためバンドルサイズが増加する。  
> プロダクションで LP の軽量性を優先する場合は `<iframe src="/app/">` 方式を検討すること。

### JS Interop の使用箇所

| ファイル | 使用する Web API |
|---|---|
| `navbar.dart` | `window.scrollY`（スクロール量取得） |
| `flutter_demo_section.dart` | `IntersectionObserver`（表示検知） |
| `features_section.dart` | `IntersectionObserver`（フェードイン） |

---

## flutter_app/ — Flutter Web SNS アプリ

### ビルド

```sh
flutter build web --base-href /jaspr-example/app/
# → flutter_app/build/web/ に出力
```

`--base-href` を指定することで `/app/` サブパスに正しく配置できる。

### 構成方針

LP とは完全に独立したプロジェクト。ユーザーが LP の「アプリを使う」ボタンから遷移する先。  
`/app/` を直接開いても動作する。

---

## デプロイフロー

```
main ブランチへの push
        │
        ▼
┌─────────────────────────┐
│ GitHub Actions          │
│                         │
│ 1. Flutter Web ビルド   │ → flutter_app/build/web/
│ 2. Jaspr LP ビルド      │ → lp/build/web/
│ 3. dist/ にマージ       │
│    dist/        ← LP    │
│    dist/app/    ← Flutter│
│ 4. gh-pages にデプロイ  │
└─────────────────────────┘
        │
        ▼
GitHub Pages 公開
```

### なぜ 2 つを分けるか

- LP は HTML として静的配信 → 初期表示が速く SEO に有利
- Flutter Web はキャンバスベース → インタラクティブなアプリ体験
- 両者を同一ドメインの別パスに置くことでユーザーが自然に遷移できる

---

## パフォーマンス目標

| 指標 | 目標 |
|---|---|
| LP Lighthouse Performance | 90+ |
| LP First Contentful Paint | < 1.5s |
| LP Total Blocking Time | < 200ms |
| Flutter Web 初期ロード | < 3s（Canvaskit） |

LP の FlutterView セクションは遅延ロード（`IntersectionObserver` で画面内に入ったタイミングで初期化）することで LP 全体の初期パフォーマンスを保護する。
