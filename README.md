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
        └── deploy.yml   # GitHub Pages へのデプロイ
```

## デプロイ先 URL 構造

```
https://<user>.github.io/jaspr-example/          # Jaspr LP
https://<user>.github.io/jaspr-example/app/      # Flutter Web App
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

`main` ブランチへのプッシュで GitHub Actions が自動実行されます。

1. Flutter Web をビルド → `dist/app/` に配置
2. Jaspr LP をビルド → `dist/` に配置
3. `actions/upload-pages-artifact` で `dist/` をアーティファクト化し、`actions/deploy-pages` で GitHub Pages へ直接デプロイ

GitHub Pages の Source 設定は **GitHub Actions** にする必要があります（`gh-pages` ブランチは使用しません）。

詳細は [docs/architecture.md](docs/architecture.md) および [.github/workflows/deploy.yml](.github/workflows/deploy.yml) を参照。

## 技術スタック

- **Jaspr** `^0.15.0` — Dart Web フレームワーク（SSG モード）
- **jaspr_flutter_embed** `^0.15.0` — Jaspr 内への Flutter View 埋め込み
- **Flutter** `3.41.9` — Flutter Web App（`/app/` パス）
- **FVM** — Flutter バージョン管理
