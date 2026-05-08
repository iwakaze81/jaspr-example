library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import 'app.dart';
import 'main.server.options.dart';

void main() {
  Jaspr.initializeApp(options: defaultServerOptions);

  const base = String.fromEnvironment('BASE_HREF', defaultValue: '/');

  runApp(Document(
    title: 'Pulse — Flutter SNS',
    base: base,
    styles: [
      css.import('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap'),
      css('*, *::before, *::after').styles(boxSizing: .borderBox),
      css('html, body').styles(
        width: 100.percent,
        minHeight: 100.vh,
        margin: .zero,
        padding: .zero,
        fontFamily: const .list([FontFamily('Inter'), FontFamilies.sansSerif]),
        backgroundColor: const Color('#0a0a0f'),
        color: const Color('#f1f5f9'),
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
      // jaspr_flutter_embed に必要な Flutter bootstrap スクリプト
      script(src: 'flutter_bootstrap.js', async: true),
    ],
    body: const App(),
  ));
}
