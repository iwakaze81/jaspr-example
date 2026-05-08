import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_flutter_embed/jaspr_flutter_embed.dart';

import '../../styles/theme.dart';
import '../ui/badge.dart';

// Flutter Widget は Web のみで読み込む（サーバー/ビルド時は Flutter を import しない）
// jaspr_builder がこのアノテーションから .imports.dart を自動生成する
@Import.onWeb('../../widgets/feed_preview.dart', show: [#FeedPreviewWidget])
import 'flutter_demo_section.imports.dart' deferred as feed;

class FlutterDemoSection extends StatelessComponent {
  const FlutterDemoSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      id: 'demo',
      classes: 'demo-section',
      [
        div(classes: 'demo-section__inner', [
          div(classes: 'demo-section__text', [
            const Badge(label: '✦ Powered by jaspr_flutter_embed'),
            h2(classes: 'section-title demo-section__title', [
              Component.text('Experience the app,'),
              br(),
              span(classes: 'gradient-text', [Component.text('right here.')]),
            ]),
            p(classes: 'section-subtitle demo-section__desc', [
              Component.text('This interactive demo is a real Flutter widget embedded directly in this HTML page using '),
              code([Component.text('jaspr_flutter_embed')]),
              Component.text('. No iframe, no redirect — Flutter running inside the DOM.'),
            ]),
            div(classes: 'demo-section__features', [
              _point('⚡️ Native Flutter rendering'),
              _point('🎨 Flutter animations & gestures'),
              _point('🔗 Communicates with Jaspr state'),
            ]),
          ]),
          div(classes: 'demo-section__embed', [
            // FlutterEmbedView.deferred は画面に入るまで Flutter を初期化しない
            // → LP 全体の初期 FCP を保護する重要なパフォーマンス最適化
            FlutterEmbedView.deferred(
              styles: Styles(height: 580.px),
              constraints: ViewConstraints(
                minWidth: 320,
                minHeight: 580,
                maxWidth: 400,
                maxHeight: 580,
              ),
              loadLibrary: feed.loadLibrary(),
              builder: () => feed.FeedPreviewWidget(),
            ),
            p(classes: 'demo-section__caption', [
              Component.text('↑ This is Flutter, running natively in your browser'),
            ]),
          ]),
        ]),
      ],
    );
  }

  Component _point(String label) {
    return div(classes: 'demo-feature', [
      span(classes: 'demo-feature__text', [Component.text(label)]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.demo-section').styles(
      padding: Padding.symmetric(vertical: 6.rem, horizontal: 1.5.rem),
      raw: {'background': 'radial-gradient(ellipse at center, rgba(99,102,241,0.08) 0%, transparent 70%)'},
    ),
    css('.demo-section__inner').styles(
      display: .flex,
      alignItems: .center,
      justifyContent: .spaceBetween,
      maxWidth: 1200.px,
      margin: Margin.only(left: Unit.auto, right: Unit.auto),
      gap: Gap(row: 4.rem, column: 4.rem),
    ),
    css('.demo-section__text').styles(
      flex: Flex(grow: 1, shrink: 1, basis: 0.px),
      display: .flex,
      flexDirection: .column,
      gap: Gap(row: 1.5.rem, column: 1.5.rem),
    ),
    css('.demo-section__title').styles(textAlign: .left, margin: .zero),
    css('.demo-section__desc').styles(margin: .zero, maxWidth: 440.px),
    css('.demo-section__desc code').styles(
      color: primaryColor,
      fontSize: 0.9.em,
      raw: {'font-family': 'monospace'},
    ),
    css('.demo-section__features').styles(
      display: .flex,
      flexDirection: .column,
      gap: Gap(row: 0.75.rem, column: 0.75.rem),
    ),
    css('.demo-feature__text').styles(
      fontSize: 0.9375.rem,
      color: textSecondaryColor,
    ),
    css('.demo-section__embed').styles(
      flex: Flex(grow: 1, shrink: 1, basis: 0.px),
      display: .flex,
      flexDirection: .column,
      alignItems: .center,
      gap: Gap(row: 1.rem, column: 1.rem),
    ),
    css('.demo-section__caption').styles(
      fontSize: 0.8125.rem,
      color: textMutedColor,
      textAlign: .center,
      margin: .zero,
    ),
    css.media(MediaQuery.raw('(max-width: 900px)'), [
      css('.demo-section__inner').styles(flexDirection: .column),
    ]),
  ];
}
