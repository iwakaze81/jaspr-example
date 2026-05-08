import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../styles/theme.dart';
import '../ui/button.dart';

class CtaSection extends StatelessComponent {
  const CtaSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(classes: 'cta-section', [
      div(classes: 'cta-section__inner', [
        h2(classes: 'cta-section__title', [
          text('Ready to join'),
          br(),
          span(classes: 'gradient-text', [text('Pulse?')]),
        ]),
        p(classes: 'cta-section__desc', [
          text('Start for free. Available on Web, iOS, and Android.'),
          br(),
          text('Built with Flutter — one app, everywhere.'),
        ]),
        div(classes: 'cta-section__actions', [
          const AppButton(label: 'Try Web App', href: '/jaspr-example/app/', size: 'lg'),
          const AppButton(label: '↓ App Store', href: '#', variant: ButtonVariant.secondary, size: 'lg'),
          const AppButton(label: '↓ Google Play', href: '#', variant: ButtonVariant.secondary, size: 'lg'),
        ]),
        p(classes: 'cta-section__note', [text('No credit card required. Free forever for personal use.')]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.cta-section').styles(
      padding: Padding.symmetric(vertical: 6.rem, horizontal: 1.5.rem),
      textAlign: .center,
      raw: {'background': 'radial-gradient(ellipse at center, rgba(99,102,241,0.12) 0%, transparent 70%)'},
    ),
    css('.cta-section__inner').styles(
      maxWidth: 680.px,
      margin: Margin.only(left: Unit.auto, right: Unit.auto),
      display: .flex,
      flexDirection: .column,
      alignItems: .center,
      gap: Gap(row: 1.5.rem, column: 1.5.rem),
    ),
    css('.cta-section__title').styles(
      fontSize: 3.rem,
      fontWeight: FontWeight.w800,
      margin: .zero,
      lineHeight: Unit.expression('1.1'),
    ),
    css('.cta-section__desc').styles(
      fontSize: 1.125.rem,
      color: textSecondaryColor,
      lineHeight: Unit.expression('1.7'),
      margin: .zero,
    ),
    css('.cta-section__actions').styles(
      display: .flex,
      gap: Gap(row: 1.rem, column: 1.rem),
      flexWrap: .wrap,
      justifyContent: .center,
    ),
    css('.cta-section__note').styles(
      fontSize: 0.875.rem,
      color: textMutedColor,
      margin: .zero,
    ),
    css.media(MediaQuery.raw('(max-width: 600px)'), [
      css('.cta-section__title').styles(fontSize: 2.25.rem),
    ]),
  ];
}
