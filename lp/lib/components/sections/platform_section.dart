import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../i18n/locale_provider.dart';
import '../../styles/theme.dart';
import '../ui/section_wrapper.dart';

class PlatformSection extends StatelessComponent {
  const PlatformSection({super.key});

  @override
  Component build(BuildContext context) {
    final s = LocaleProvider.of(context).strings;
    return SectionWrapper(
      id: 'platform',
      classes: 'platform-section',
      children: [
        div(classes: 'platform-section__header', [
          h2(classes: 'section-title', [
            Component.text(s.platformTitle1),
            br(),
            span(classes: 'gradient-text', [Component.text(s.platformTitle2)]),
          ]),
          p(classes: 'section-subtitle', [Component.text(s.platformSubtitle)]),
        ]),
        div(classes: 'platform-cards', s.platforms.map(_buildCard).toList()),
        div(classes: 'flutter-metrics', [
          _metric('1', s.metricCodebase, s.metricCodebaseSub),
          _metric('60fps', s.metricRendering, s.metricRenderingSub),
          _metric('<3s', s.metricColdStart, s.metricColdStartSub),
          _metric('100', s.metricLighthouse, s.metricLighthouseSub),
        ]),
      ],
    );
  }

  Component _buildCard(({String icon, String title, String desc, List<String> features}) platform) {
    return div(classes: 'platform-card', [
      div(classes: 'platform-card__icon', [Component.text(platform.icon)]),
      h3(classes: 'platform-card__title', [Component.text(platform.title)]),
      p(classes: 'platform-card__desc', [Component.text(platform.desc)]),
      ul(classes: 'platform-card__features', platform.features.map((f) => li([Component.text('✓  $f')])).toList()),
    ]);
  }

  Component _metric(String value, String label, String sub) {
    return div(classes: 'flutter-metric', [
      span(classes: 'flutter-metric__value gradient-text', [Component.text(value)]),
      span(classes: 'flutter-metric__label', [Component.text(label)]),
      span(classes: 'flutter-metric__sub', [Component.text(sub)]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.platform-section__header').styles(
      textAlign: .center,
      margin: Margin.only(bottom: 4.rem),
    ),
    css('.platform-cards').styles(
      display: .grid,
      gap: Gap(row: 1.5.rem, column: 1.5.rem),
      raw: {'grid-template-columns': 'repeat(3, 1fr)'},
    ),
    css('.platform-card').styles(
      padding: .all(2.rem),
      radius: BorderRadius.circular(1.rem),
      backgroundColor: surfaceColor,
      border: Border.all(width: 1.px, color: borderColor),
    ),
    css('.platform-card__icon').styles(
      fontSize: 2.5.rem,
      margin: Margin.only(bottom: 1.rem),
    ),
    css('.platform-card__title').styles(
      fontSize: 1.25.rem,
      fontWeight: FontWeight.w700,
      margin: Margin.only(bottom: 0.75.rem),
      color: textPrimaryColor,
    ),
    css('.platform-card__desc').styles(
      fontSize: 0.9375.rem,
      color: textSecondaryColor,
      lineHeight: Unit.expression('1.6'),
      margin: Margin.only(bottom: 1.25.rem),
    ),
    css('.platform-card__features').styles(
      listStyle: ListStyle.none,
      padding: .zero,
      margin: .zero,
      display: .flex,
      flexDirection: .column,
      gap: Gap(row: 0.375.rem, column: 0.375.rem),
    ),
    css('.platform-card__features li').styles(
      fontSize: 0.875.rem,
      color: textMutedColor,
    ),
    css('.flutter-metrics').styles(
      display: .grid,
      gap: Gap(row: 1.5.rem, column: 1.5.rem),
      margin: Margin.only(top: 4.rem),
      textAlign: .center,
      raw: {'grid-template-columns': 'repeat(4, 1fr)'},
    ),
    css('.flutter-metric').styles(
      display: .flex,
      flexDirection: .column,
      gap: Gap(row: 0.25.rem, column: 0.25.rem),
    ),
    css('.flutter-metric__value').styles(fontSize: 2.5.rem, fontWeight: FontWeight.w800),
    css('.flutter-metric__label').styles(fontWeight: FontWeight.w600, color: textPrimaryColor),
    css('.flutter-metric__sub').styles(fontSize: 0.875.rem, color: textMutedColor),
    css.media(MediaQuery.raw('(max-width: 900px)'), [
      css('.platform-cards').styles(raw: {'grid-template-columns': '1fr'}),
      css('.flutter-metrics').styles(raw: {'grid-template-columns': 'repeat(2, 1fr)'}),
    ]),
  ];
}
