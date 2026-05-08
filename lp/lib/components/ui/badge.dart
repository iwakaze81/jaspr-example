import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../styles/theme.dart';

class Badge extends StatelessComponent {
  const Badge({required this.label, super.key});

  final String label;

  @override
  Component build(BuildContext context) {
    return span(classes: 'badge', [Component.text(label)]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.badge').styles(
      display: .inlineFlex,
      alignItems: .center,
      padding: Padding.symmetric(vertical: 0.375.rem, horizontal: 1.rem),
      fontSize: 0.75.rem,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.05.em,
      radius: BorderRadius.circular(9999.px),
      border: Border.all(width: 1.px, color: primaryColor),
      color: primaryColor,
      raw: {
        'background': 'rgba(99, 102, 241, 0.1)',
        'text-transform': 'uppercase',
      },
    ),
  ];
}
