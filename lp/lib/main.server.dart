library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import 'app.dart';
import 'main.server.options.dart';

// data-theme 属性を初期描画前に設定し、ライト/ダークの FOUC を防ぐ。
// localStorage に保存値があればそれを優先、なければ prefers-color-scheme を採用。
const _themeInitScript = '''
(function(){try{var t=localStorage.getItem('pulse-theme');var p=window.matchMedia('(prefers-color-scheme: light)').matches?'light':'dark';document.documentElement.setAttribute('data-theme',t||p);}catch(e){document.documentElement.setAttribute('data-theme','dark');}})();
''';

// ── テーマ定義（ダーク） ─────────────────────────────────────────────────
const _darkVars = {
  '--color-primary': '#6366f1',
  '--color-primary-dark': '#4f46e5',
  '--color-bg': '#0a0a0f',
  '--color-surface': '#111118',
  '--color-surface-elevated': '#1a1a2e',
  '--color-border': '#1e1e2e',
  '--color-text-primary': '#f1f5f9',
  '--color-text-secondary': '#94a3b8',
  '--color-text-muted': '#475569',
  '--color-navbar-bg': 'rgba(10, 10, 15, 0.85)',
  '--color-navbar-border': 'rgba(255, 255, 255, 0.06)',
};

// ── テーマ定義（ライト） ─────────────────────────────────────────────────
const _lightVars = {
  '--color-primary': '#6366f1',
  '--color-primary-dark': '#4f46e5',
  '--color-bg': '#ffffff',
  '--color-surface': '#f8fafc',
  '--color-surface-elevated': '#f1f5f9',
  '--color-border': '#e2e8f0',
  '--color-text-primary': '#0f172a',
  '--color-text-secondary': '#475569',
  '--color-text-muted': '#94a3b8',
  '--color-navbar-bg': 'rgba(255, 255, 255, 0.85)',
  '--color-navbar-border': 'rgba(15, 23, 42, 0.06)',
};

void main() {
  Jaspr.initializeApp(options: defaultServerOptions);

  const base = String.fromEnvironment('BASE_HREF', defaultValue: '/');

  runApp(Document(
    title: 'Pulse — Flutter SNS',
    base: base,
    styles: [
      css.import('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap'),
      // デフォルト（ダーク）。data-theme 未設定時のフォールバック。
      css(':root').styles(raw: _darkVars),
      // 未指定時、システム設定がライトならライトを採用。
      css.media(MediaQuery.raw('(prefers-color-scheme: light)'), [
        css(':root:not([data-theme])').styles(raw: _lightVars),
      ]),
      // 明示指定（toggle 押下またはインラインスクリプトで設定）。
      css(':root[data-theme="light"]').styles(raw: _lightVars),
      css(':root[data-theme="dark"]').styles(raw: _darkVars),
      css('*, *::before, *::after').styles(boxSizing: .borderBox),
      css('html, body').styles(
        width: 100.percent,
        minHeight: 100.vh,
        margin: .zero,
        padding: .zero,
        fontFamily: const .list([FontFamily('Inter'), FontFamilies.sansSerif]),
        backgroundColor: const Color('var(--color-bg)'),
        color: const Color('var(--color-text-primary)'),
        raw: {'transition': 'background-color 200ms ease, color 200ms ease'},
      ),
      css('a').styles(color: Color.inherit, textDecoration: .none),
      css('img, svg').styles(display: .block, maxWidth: 100.percent),
      // グラデーションテキストユーティリティ（CSS-in-Dart の raw: で任意 CSS を記述）
      css('.gradient-text').styles(raw: {
        'background': 'linear-gradient(135deg, #6366f1, #a78bfa)',
        '-webkit-background-clip': 'text',
        '-webkit-text-fill-color': 'transparent',
        'background-clip': 'text',
      }),
    ],
    head: [
      meta(name: 'description', content: 'The social platform built entirely with Flutter — native performance on every device.'),
      meta(name: 'theme-color', content: '#6366f1'),
      link(rel: 'manifest', href: 'manifest.json'),
      // 初期テーマ判定（FOUC 防止のため body より前に同期実行）
      script(content: _themeInitScript),
      // jaspr_flutter_embed に必要な Flutter bootstrap スクリプト
      script(src: 'flutter_bootstrap.js', async: true),
    ],
    body: const App(),
  ));
}
