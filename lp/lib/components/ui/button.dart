import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../styles/theme.dart';

enum ButtonVariant { primary, secondary, ghost }

class AppButton extends StatelessComponent {
  const AppButton({
    required this.label,
    this.href,
    this.variant = ButtonVariant.primary,
    this.size = 'md',
    super.key,
  });

  final String label;
  final String? href;
  final ButtonVariant variant;
  final String size;

  @override
  Component build(BuildContext context) {
    final classes = 'btn btn--${variant.name} btn--$size';
    if (href != null) {
      return a(href: href!, classes: classes, [text(label)]);
    }
    return button(classes: classes, [text(label)]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.btn').styles(
      display: .inlineFlex,
      alignItems: .center,
      justifyContent: .center,
      fontWeight: FontWeight.w600,
      cursor: .pointer,
      border: Border.none,
      textDecoration: .none,
      transition: Transition('all', duration: const Duration(milliseconds: 200)),
    ),
    css('.btn--md').styles(
      padding: Padding.symmetric(vertical: 0.75.rem, horizontal: 1.75.rem),
      fontSize: 1.rem,
      radius: BorderRadius.circular(9999.px),
    ),
    css('.btn--lg').styles(
      padding: Padding.symmetric(vertical: 1.rem, horizontal: 2.25.rem),
      fontSize: 1.125.rem,
      radius: BorderRadius.circular(9999.px),
    ),
    css('.btn--primary').styles(
      backgroundColor: primaryColor,
      color: const Color('#ffffff'),
    ),
    css('.btn--primary:hover').styles(backgroundColor: primaryDarkColor),
    css('.btn--secondary').styles(
      backgroundColor: surfaceElevatedColor,
      color: textPrimaryColor,
      border: Border.all(width: 1.px, color: borderColor),
    ),
    css('.btn--secondary:hover').styles(border: Border.all(width: 1.px, color: primaryColor)),
    css('.btn--ghost').styles(
      backgroundColor: const Color('transparent'),
      color: textSecondaryColor,
    ),
    css('.btn--ghost:hover').styles(color: textPrimaryColor),
  ];
}
