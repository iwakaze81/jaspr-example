# Pulse — Jaspr LP Example

**Pulse** は Flutter で作られた架空の toC 向け SNS サービスです。  
このリポジトリは [Jaspr](https://docs.page/schultek/jaspr) を使ったランディングページ（LP）のサンプルプロジェクトです。

## デモ

GitHub Pages にデプロイ済みの動作デモを公開しています。

| サイト | URL |
|---|---|
| Jaspr LP | <https://iwakaze81.github.io/jaspr-example/> |
| Flutter Web App | <https://iwakaze81.github.io/jaspr-example/app/> |

LP 内の「Try it live」セクションでは、`jaspr_flutter_embed` で Flutter のフィードウィジェットを HTML ページに直接埋め込んでいる様子が確認できます。

## このプロジェクトが示すもの

| 機能 | 実装箇所 |
|---|---|
| Jaspr Static Site Generation | `lp/` 全体 |
| CSS-in-Dart（StyleSheet API） | `lp/lib/styles/` |
| CSS Custom Properties によるダーク/ライトモード | `lp/lib/styles/theme.dart` |
| `jaspr_flutter_embed` で Flutter Widget を LP に埋め込み | `lp/lib/components/sections/flutter_demo_section.dart` |
| JS Interop（IntersectionObserver / scroll） | `lp/lib/components/layout/navbar.dart` |
| スクロールトリガー アニメーション | `lp/lib/styles/animations.dart` |
| レスポンシブレイアウト | `lp/lib/styles/breakpoints.dart` |
| Flutter Web 独立デプロイ（`/app/` パス） | `flutter_app/` |

## リポジトリ構成

```
jaspr-example/
├── lp/                  # Jaspr LP（静的サイト）
├── flutter_app/         # Flutter Web SNS アプリ
├── docs/
│   └── architecture.md  # 技術設計ドキュメント
└── .github/
    └── workflows/
        ├── deploy.yml   # main → 本番デプロイ（gh-pages ブランチ root）
        └── preview.yml  # PR → プレビューデプロイ（gh-pages の pr-preview/pr-N/）
```

## デプロイ先 URL 構造

```
https://<user>.github.io/jaspr-example/                   # Jaspr LP（本番）
https://<user>.github.io/jaspr-example/app/               # Flutter Web App（本番）
https://<user>.github.io/jaspr-example/pr-preview/pr-N/   # PR #N の LP プレビュー
```

## ローカル開発

このプロジェクトは [FVM](https://fvm.app/) で Flutter バージョンを管理しています。

```sh
# FVM セットアップ（初回のみ）
dart pub global activate fvm
fvm install
```

### LP（Jaspr）

```sh
cd lp
fvm dart pub get
fvm dart run jaspr serve          # 開発サーバー起動 → http://localhost:8080
fvm dart run jaspr build          # 静的ビルド → lp/build/web/
```

### Flutter Web App

```sh
cd flutter_app
fvm flutter pub get
fvm flutter run -d chrome         # Chrome で起動
fvm flutter build web --base-href /jaspr-example/app/
```

## デプロイ

本番と PR プレビューはどちらも `gh-pages` ブランチに同居させる構成です。

### 本番デプロイ（`main` への push）

[.github/workflows/deploy.yml](.github/workflows/deploy.yml)

1. Flutter Web をビルド → `dist/app/` に配置
2. Jaspr LP をビルド → `dist/` に配置
3. `JamesIves/github-pages-deploy-action` で `dist/` を `gh-pages` ブランチの root に publish
   - `clean-exclude: pr-preview` で PR プレビュー用ディレクトリは保持

### PR プレビュー（PR への push）

[.github/workflows/preview.yml](.github/workflows/preview.yml)

1. Jaspr LP のみビルド（`BASE_HREF=/jaspr-example/pr-preview/pr-N/`）
2. `rossjrw/pr-preview-action` で `gh-pages` の `pr-preview/pr-N/` 以下にデプロイ
3. PR にプレビュー URL がコメント投稿される
4. PR が close されるとプレビューは自動削除

> フォーク元 PR ではシークレット書込権限が無いためプレビューはスキップされます。

### GitHub Pages の Source 設定

リポジトリ Settings → Pages で以下を設定してください。

- **Source**: Deploy from a branch
- **Branch**: `gh-pages` / `(root)`

詳細は [docs/architecture.md](docs/architecture.md) を参照。

## 技術スタック

- **Jaspr** `^0.15.0` — Dart Web フレームワーク（SSG モード）
- **jaspr_flutter_embed** `^0.15.0` — Jaspr 内への Flutter View 埋め込み
- **Flutter** `3.41.9` — Flutter Web App（`/app/` パス）
- **FVM** — Flutter バージョン管理
