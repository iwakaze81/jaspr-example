import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../styles/theme.dart';
import '../ui/badge.dart';
import '../ui/button.dart';

class HeroSection extends StatelessComponent {
  const HeroSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(classes: 'hero', [
      div(classes: 'hero__content', [
        const Badge(label: '✦ Open Beta — Join Now'),
        h1(classes: 'hero__title', [
          span([Component.text('Connect. Share.')]),
          br(),
          span(classes: 'gradient-text', [Component.text('Thrive. Together.')]),
        ]),
        p(classes: 'hero__subtitle', [
          Component.text('The social platform built entirely with Flutter — native performance on Web, iOS, and Android from a single codebase.'),
        ]),
        div(classes: 'hero__actions', [
          const AppButton(label: 'Get Started Free', href: '/app/', size: 'lg'),
          const AppButton(label: 'Live Demo ↓', href: '#demo', variant: ButtonVariant.secondary, size: 'lg'),
        ]),
        div(classes: 'hero__platforms', [
          span(classes: 'platform-badge', [Component.text('🌐 Web')]),
          span(classes: 'platform-badge', [Component.text('📱 iOS')]),
          span(classes: 'platform-badge', [Component.text('📱 Android')]),
        ]),
      ]),
      div(classes: 'hero__visual', [_deviceMockup()]),
    ]);
  }

  Component _deviceMockup() {
    return div(classes: 'mockup', [
      div(classes: 'mockup__phone', [
        div(classes: 'mockup__screen', [
          _post('mockup__avatar', 'Yuki T.', 'Flutter makes cross-platform feel native 🚀', '❤️ 142', '💬 38'),
          _post('mockup__avatar--2', 'Taro M.', 'Just shipped the new feature ✨ Built with Pulse!', '❤️ 98', '💬 21'),
        ]),
      ]),
    ]);
  }

  Component _post(String avatarClass, String name, String body, String likes, String comments) {
    return div(classes: 'mockup__post', [
      div(classes: 'mockup__avatar $avatarClass', []),
      div(classes: 'mockup__text', [
        div(classes: 'mockup__name', [Component.text(name)]),
        div(classes: 'mockup__body', [Component.text(body)]),
        div(classes: 'mockup__actions', [span([Component.text(likes)]), span([Component.text(comments)])]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.hero').styles(
      display: .flex,
      alignItems: .center,
      justifyContent: .spaceBetween,
      maxWidth: 1200.px,
      margin: Margin.only(left: Unit.auto, right: Unit.auto),
      padding: Padding.only(top: 10.rem, bottom: 6.rem, left: 1.5.rem, right: 1.5.rem),
      gap: Gap(row: 4.rem, column: 4.rem),
    ),
    css('.hero__content').styles(
      flex: Flex(grow: 1, shrink: 1, basis: 0.px),
      display: .flex,
      flexDirection: .column,
      alignItems: .start,
      gap: Gap(row: 1.5.rem, column: 1.5.rem),
    ),
    css('.hero__title').styles(
      fontSize: 3.75.rem,
      fontWeight: FontWeight.w800,
      lineHeight: Unit.expression('1.1'),
      margin: .zero,
      color: textPrimaryColor,
    ),
    css('.hero__subtitle').styles(
      fontSize: 1.125.rem,
      color: textSecondaryColor,
      lineHeight: Unit.expression('1.7'),
      maxWidth: 480.px,
      margin: .zero,
    ),
    css('.hero__actions').styles(
      display: .flex,
      gap: Gap(row: 1.rem, column: 1.rem),
      flexWrap: .wrap,
    ),
    css('.hero__platforms').styles(
      display: .flex,
      gap: Gap(row: 0.75.rem, column: 0.75.rem),
      flexWrap: .wrap,
    ),
    css('.platform-badge').styles(
      fontSize: 0.875.rem,
      color: textMutedColor,
      padding: Padding.symmetric(vertical: 0.25.rem, horizontal: 0.75.rem),
      radius: BorderRadius.circular(9999.px),
      border: Border.all(width: 1.px, color: borderColor),
    ),
    css('.hero__visual').styles(
      flex: Flex(grow: 1, shrink: 1, basis: 0.px),
      display: .flex,
      justifyContent: .center,
    ),
    css('.mockup__phone').styles(
      width: 300.px,
      radius: BorderRadius.circular(2.rem),
      border: Border.all(width: 2.px, color: borderColor),
      backgroundColor: surfaceColor,
      overflow: Overflow.hidden,
      padding: .all(1.rem),
      display: .flex,
      flexDirection: .column,
      gap: Gap(row: 1.rem, column: 1.rem),
    ),
    css('.mockup__screen').styles(
      display: .flex,
      flexDirection: .column,
      gap: Gap(row: 1.rem, column: 1.rem),
    ),
    css('.mockup__post').styles(
      display: .flex,
      gap: Gap(row: 0.75.rem, column: 0.75.rem),
      padding: .all(0.75.rem),
      radius: BorderRadius.circular(0.75.rem),
      backgroundColor: surfaceElevatedColor,
    ),
    css('.mockup__avatar').styles(
      width: 36.px,
      height: 36.px,
      radius: BorderRadius.circular(9999.px),
      raw: {'background': 'linear-gradient(135deg, #6366f1, #a78bfa)', 'flex-shrink': '0'},
    ),
    css('.mockup__avatar--2').styles(
      raw: {'background': 'linear-gradient(135deg, #ec4899, #f97316)'},
    ),
    css('.mockup__name').styles(fontSize: 0.8125.rem, fontWeight: FontWeight.w600),
    css('.mockup__body').styles(
      fontSize: 0.875.rem,
      color: textSecondaryColor,
      margin: Margin.only(top: 0.25.rem),
    ),
    css('.mockup__actions').styles(
      display: .flex,
      gap: Gap(row: 1.rem, column: 1.rem),
      margin: Margin.only(top: 0.5.rem),
      fontSize: 0.75.rem,
      color: textMutedColor,
    ),
    css.media(MediaQuery.raw('(max-width: 900px)'), [
      css('.hero').styles(flexDirection: .column, padding: Padding.only(top: 7.rem, bottom: 6.rem, left: 1.5.rem, right: 1.5.rem)),
      css('.hero__title').styles(fontSize: 2.75.rem),
      css('.hero__visual').styles(display: .none),
    ]),
  ];
}
