import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../i18n/locale_provider.dart';
import '../../styles/theme.dart';
import '../ui/section_wrapper.dart';

class FeaturesSection extends StatelessComponent {
  const FeaturesSection({super.key});

  @override
  Component build(BuildContext context) {
    final s = LocaleProvider.of(context).strings;
    return SectionWrapper(
      id: 'features',
      classes: 'features-section',
      children: [
        div(classes: 'features-section__header', [
          h2(classes: 'section-title', [Component.text(s.featuresTitle)]),
          p(classes: 'section-subtitle', [Component.text(s.featuresSubtitle)]),
        ]),
        div(classes: 'features-grid', s.features.map(_buildCard).toList()),
      ],
    );
  }

  Component _buildCard(({String icon, String title, String desc}) f) {
    return div(classes: 'feature-card', [
      div(classes: 'feature-card__icon', [Component.text(f.icon)]),
      h3(classes: 'feature-card__title', [Component.text(f.title)]),
      p(classes: 'feature-card__desc', [Component.text(f.desc)]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.features-section__header').styles(
      textAlign: .center,
      margin: Margin.only(bottom: 4.rem),
    ),
    css('.section-title').styles(
      fontSize: 2.5.rem,
      fontWeight: FontWeight.w700,
      margin: Margin.only(bottom: 1.rem),
      color: textPrimaryColor,
    ),
    css('.section-subtitle').styles(
      fontSize: 1.125.rem,
      color: textSecondaryColor,
      maxWidth: 560.px,
      margin: Margin.only(left: Unit.auto, right: Unit.auto),
      lineHeight: Unit.expression('1.7'),
    ),
    css('.features-grid').styles(
      display: .grid,
      gap: Gap(row: 1.5.rem, column: 1.5.rem),
      raw: {'grid-template-columns': 'repeat(3, 1fr)'},
    ),
    css('.feature-card').styles(
      padding: .all(1.75.rem),
      radius: BorderRadius.circular(1.rem),
      backgroundColor: surfaceColor,
      border: Border.all(width: 1.px, color: borderColor),
      transition: Transition.combine([
        Transition('border-color', duration: const Duration(milliseconds: 200)),
        Transition('transform', duration: const Duration(milliseconds: 200)),
      ]),
    ),
    css('.feature-card:hover').styles(
      border: Border.all(width: 1.px, color: primaryColor),
      raw: {'transform': 'translateY(-2px)'},
    ),
    css('.feature-card__icon').styles(
      fontSize: 2.rem,
      margin: Margin.only(bottom: 1.rem),
    ),
    css('.feature-card__title').styles(
      fontSize: 1.125.rem,
      fontWeight: FontWeight.w600,
      margin: Margin.only(bottom: 0.5.rem),
      color: textPrimaryColor,
    ),
    css('.feature-card__desc').styles(
      fontSize: 0.9375.rem,
      color: textSecondaryColor,
      lineHeight: Unit.expression('1.6'),
      margin: .zero,
    ),
    css.media(MediaQuery.raw('(max-width: 900px)'), [
      css('.features-grid').styles(raw: {'grid-template-columns': 'repeat(2, 1fr)'}),
    ]),
    css.media(MediaQuery.raw('(max-width: 600px)'), [
      css('.features-grid').styles(raw: {'grid-template-columns': '1fr'}),
      css('.section-title').styles(fontSize: 2.rem),
    ]),
  ];
}
