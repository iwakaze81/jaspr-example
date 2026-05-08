# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

**Pulse** — Flutter 製 toC 向け SNS「Pulse」のランディングページサンプル。  
Jaspr（Dart Web フレームワーク）の機能を実践的に示すことを目的としたモノレポ。

```
jaspr-example/
├── lp/           # Jaspr LP（静的サイト生成）
├── flutter_app/  # Flutter Web SNS アプリ（/app/ パス）
└── docs/         # 設計ドキュメント
```

デプロイ先構造:
- `/` → Jaspr LP
- `/app/` → Flutter Web App

## Flutter バージョン

Flutter **3.41.9** を [FVM](https://fvm.app/) で管理。すべてのコマンドに `fvm` を付ける。

## コマンド

### LP（Jaspr） — `cd lp` してから実行

```sh
fvm flutter pub get                        # 依存関係インストール
fvm dart run jaspr_cli:jaspr serve         # 開発サーバー → http://localhost:8080
fvm dart run jaspr_cli:jaspr build         # 静的ビルド → lp/build/web/
fvm dart analyze lib/                      # 静的解析
fvm dart format .                          # フォーマット
fvm dart run build_runner build            # コード生成（options.dart / imports.dart）
```

### Flutter Web App — `cd flutter_app` してから実行

```sh
fvm flutter pub get
fvm flutter run -d chrome
fvm flutter build web --base-href /jaspr-example/app/
fvm flutter test
fvm flutter test test/path/to/test_file.dart   # 単一テスト
```

## アーキテクチャ

詳細は [docs/architecture.md](docs/architecture.md) を参照。

### lp/ の構成

- `lib/components/ui/` — 汎用コンポーネント（Button, Card, Badge, SectionWrapper）
- `lib/components/layout/` — Navbar（JS Interop でスクロール検知）、Footer
- `lib/components/sections/` — LP の各セクション
- `lib/components/sections/flutter_demo_section.dart` — `jaspr_flutter_embed` で Flutter Widget を埋め込む核心
- `lib/styles/` — CSS-in-Dart。`theme.dart` で CSS Custom Properties を定義しダーク/ライトモードを管理
- `lib/flutter/` — FlutterView に渡す Flutter Widget 定義

### 重要なパターン

**CSS-in-Dart スタイル定義**  
各コンポーネントに `@css static List<StyleRule> get styles => [...]` を定義する。`@css` は **public** クラス・メンバのみに付与可能。`jaspr_builder` が自動収集して `<style>` に埋め込む。

**Jaspr 0.23.x API 注意点**
- `gap:` は `Gap(row: 1.5.rem, column: 1.5.rem)` を使う（`Unit` 直渡し不可）
- `borderRadius:` ではなく `radius: BorderRadius.circular(1.rem)`
- `margin:`/`padding:` は `Margin.only(...)` / `Padding.symmetric(...)` を使う
- `lineHeight:` は `Unit.expression('1.5')` を使う（`double` 直渡し不可）
- `background:` ではなく `backgroundColor: Color('#hex')` / rawで `'background': 'linear-gradient(...)'`
- `alignItems: .start` を使う（`.flexStart` は存在しない）
- メディアクエリは `css.media(MediaQuery.raw('(max-width: 768px)'), [...])`
- `Position.fixed(top: Unit.zero, left: Unit.zero, right: Unit.zero)` — 座標は Position コンストラクタに渡す

**FlutterView 埋め込み**  
`@Import.onWeb` アノテーションで Web 専用インポートを定義し、`jaspr_builder` が `.imports.dart` を生成する。  
`FlutterEmbedView.deferred(loadLibrary: feed.loadLibrary(), builder: () => feed.FeedPreviewWidget())` で遅延初期化。`const` は不可（deferred クラスのため）。

**JS Interop**  
`dart:js_interop` + `package:web` バインディングを優先する。

## デプロイ

`main` ブランチへのプッシュで `.github/workflows/deploy.yml` が自動実行され GitHub Pages に公開される。
