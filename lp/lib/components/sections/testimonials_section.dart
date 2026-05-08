import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../i18n/locale_provider.dart';
import '../../styles/theme.dart';
import '../ui/section_wrapper.dart';

class TestimonialsSection extends StatelessComponent {
  const TestimonialsSection({super.key});

  @override
  Component build(BuildContext context) {
    final s = LocaleProvider.of(context).strings;
    return SectionWrapper(
      id: 'testimonials',
      children: [
        h2(classes: 'section-title', [Component.text(s.testimonialsTitle)]),
        div(classes: 'testimonials-grid', s.testimonials.map(_buildCard).toList()),
      ],
    );
  }

  Component _buildCard(({String quote, String name, String handle, String avatarHex}) t) {
    return div(classes: 'testimonial-card', [
      div(classes: 'stars', [Component.text('★★★★★')]),
      p(classes: 'testimonial-card__quote', [Component.text(t.quote)]),
      div(classes: 'testimonial-card__author', [
        // インラインスタイルで個別の背景色を指定
        div(
          classes: 'testimonial-card__avatar',
          styles: Styles(backgroundColor: Color(t.avatarHex)),
          [],
        ),
        div([
          span(classes: 'testimonial-card__name', [Component.text(t.name)]),
          span(classes: 'testimonial-card__handle', [Component.text(t.handle)]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.testimonials-grid').styles(
      display: .grid,
      gap: Gap(row: 1.5.rem, column: 1.5.rem),
      margin: Margin.only(top: 3.rem),
      raw: {'grid-template-columns': 'repeat(3, 1fr)'},
    ),
    css('.testimonial-card').styles(
      padding: .all(2.rem),
      radius: BorderRadius.circular(1.rem),
      backgroundColor: surfaceColor,
      border: Border.all(width: 1.px, color: borderColor),
      display: .flex,
      flexDirection: .column,
      gap: Gap(row: 1.rem, column: 1.rem),
    ),
    css('.stars').styles(color: const Color('#f59e0b'), fontSize: 1.rem),
    css('.testimonial-card__quote').styles(
      fontSize: 0.9375.rem,
      color: textSecondaryColor,
      lineHeight: Unit.expression('1.7'),
      margin: .zero,
      flex: Flex(grow: 1, shrink: 1, basis: Unit.auto),
    ),
    css('.testimonial-card__author').styles(
      display: .flex,
      alignItems: .center,
      gap: Gap(row: 0.75.rem, column: 0.75.rem),
    ),
    css('.testimonial-card__avatar').styles(
      width: 40.px,
      height: 40.px,
      radius: BorderRadius.circular(9999.px),
      raw: {'flex-shrink': '0'},
    ),
    css('.testimonial-card__name').styles(
      display: .block,
      fontWeight: FontWeight.w600,
      fontSize: 0.9375.rem,
    ),
    css('.testimonial-card__handle').styles(
      display: .block,
      fontSize: 0.8125.rem,
      color: textMutedColor,
    ),
    css.media(MediaQuery.raw('(max-width: 900px)'), [
      css('.testimonials-grid').styles(raw: {'grid-template-columns': '1fr'}),
    ]),
  ];
}
