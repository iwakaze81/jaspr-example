import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class SectionWrapper extends StatelessComponent {
  const SectionWrapper({
    required this.id,
    required this.children,
    this.classes = '',
    super.key,
  });

  final String id;
  final String classes;
  final List<Component> children;

  @override
  Component build(BuildContext context) {
    return section(
      id: id,
      classes: 'section-wrapper $classes',
      [div(classes: 'container', children)],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.section-wrapper').styles(
      padding: Padding.symmetric(vertical: 6.rem, horizontal: 1.5.rem),
    ),
    css('.container').styles(
      maxWidth: 1200.px,
      margin: Margin.only(left: Unit.auto, right: Unit.auto),
    ),
  ];
}
