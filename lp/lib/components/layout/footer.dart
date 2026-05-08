import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../i18n/locale_provider.dart';
import '../../styles/theme.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    final s = LocaleProvider.of(context).strings;

    return footer(classes: 'footer', [
      div(classes: 'footer__inner', [
        div(classes: 'footer__brand', [
          span(classes: 'footer__logo', [Component.text('Pulse')]),
          p(classes: 'footer__tagline', [Component.text(s.footerTagline)]),
        ]),
        div(classes: 'footer__links', [
          _linkGroup('Product', ['Features', 'Pricing', 'Changelog', 'Roadmap']),
          _linkGroup('Company', ['About', 'Blog', 'Careers', 'Press']),
          _linkGroup('Legal', ['Privacy', 'Terms', 'Security']),
        ]),
      ]),
      div(classes: 'footer__bottom', [
        p([Component.text('© 2025 Pulse. Built with Flutter & Jaspr.')]),
      ]),
    ]);
  }

  Component _linkGroup(String title, List<String> links) {
    return div(classes: 'footer__group', [
      span(classes: 'footer__group-title', [Component.text(title)]),
      ul(
        classes: 'footer__group-links',
        links
            .map(
              (l) => li([
                a(href: '#', [Component.text(l)]),
              ]),
            )
            .toList(),
      ),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.footer').styles(
      padding: Padding.only(top: 4.rem, bottom: 2.rem, left: 1.5.rem, right: 1.5.rem),
      border: Border.only(
        top: BorderSide(color: borderColor, width: 1.px),
      ),
    ),
    css('.footer__inner').styles(
      display: .flex,
      justifyContent: .spaceBetween,
      maxWidth: 1200.px,
      margin: Margin.only(left: Unit.auto, right: Unit.auto),
      gap: Gap(row: 3.rem, column: 3.rem),
      flexWrap: .wrap,
    ),
    css('.footer__logo').styles(
      fontSize: 1.25.rem,
      fontWeight: FontWeight.w800,
      raw: {
        'background': 'linear-gradient(135deg, #6366f1, #a78bfa)',
        '-webkit-background-clip': 'text',
        '-webkit-text-fill-color': 'transparent',
        'background-clip': 'text',
      },
    ),
    css('.footer__tagline').styles(
      fontSize: 0.875.rem,
      color: textMutedColor,
      margin: Margin.only(top: 0.5.rem),
    ),
    css('.footer__links').styles(
      display: .flex,
      gap: Gap(row: 3.rem, column: 3.rem),
      flexWrap: .wrap,
    ),
    css('.footer__group-title').styles(
      fontSize: 0.875.rem,
      fontWeight: FontWeight.w600,
      color: textSecondaryColor,
      display: .block,
      margin: Margin.only(bottom: 1.rem),
    ),
    css('.footer__group-links').styles(
      listStyle: ListStyle.none,
      padding: .zero,
      margin: .zero,
      display: .flex,
      flexDirection: .column,
      gap: Gap(row: 0.5.rem, column: 0.5.rem),
    ),
    css('.footer__group-links a').styles(fontSize: 0.875.rem, color: textMutedColor),
    css('.footer__group-links a:hover').styles(color: textPrimaryColor),
    css('.footer__bottom').styles(
      maxWidth: 1200.px,
      margin: Margin.only(top: 3.rem, left: Unit.auto, right: Unit.auto),
      padding: Padding.only(top: 1.5.rem),
      border: Border.only(
        top: BorderSide(color: borderColor, width: 1.px),
      ),
      textAlign: .center,
    ),
    css('.footer__bottom p').styles(fontSize: 0.875.rem, color: textMutedColor),
  ];
}
