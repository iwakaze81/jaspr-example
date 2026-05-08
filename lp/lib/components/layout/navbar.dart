import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../i18n/locale_provider.dart';
import '../../platform/theme_platform.dart';
import '../../styles/theme.dart';
import '../ui/button.dart';

class Navbar extends StatefulComponent {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => NavbarState();

  @css
  static List<StyleRule> get styles => [
    css('.navbar').styles(
      position: Position.fixed(top: Unit.zero, left: Unit.zero, right: Unit.zero),
      zIndex: ZIndex(50),
      padding: Padding.symmetric(vertical: 1.rem, horizontal: 1.5.rem),
      transition: Transition('background', duration: const Duration(milliseconds: 300)),
    ),
    css('.navbar--scrolled').styles(
      raw: {
        'background': 'var(--color-navbar-bg)',
        'backdrop-filter': 'blur(12px)',
        '-webkit-backdrop-filter': 'blur(12px)',
        'border-bottom': '1px solid var(--color-navbar-border)',
      },
    ),
    css('.navbar__inner').styles(
      display: .flex,
      alignItems: .center,
      justifyContent: .spaceBetween,
      maxWidth: 1200.px,
      margin: Margin.only(left: Unit.auto, right: Unit.auto),
    ),
    css('.navbar__logo').styles(
      fontSize: 1.5.rem,
      fontWeight: FontWeight.w800,
      textDecoration: .none,
      raw: {
        'background': 'linear-gradient(135deg, #6366f1, #a78bfa)',
        '-webkit-background-clip': 'text',
        '-webkit-text-fill-color': 'transparent',
        'background-clip': 'text',
      },
    ),
    css('.navbar__links').styles(
      display: .flex,
      alignItems: .center,
      gap: Gap(row: 2.rem, column: 2.rem),
    ),
    css('.navbar__link').styles(
      fontSize: 0.9375.rem,
      color: textSecondaryColor,
      textDecoration: .none,
    ),
    css('.navbar__link:hover').styles(color: textPrimaryColor),
    css('.locale-toggle').styles(
      display: .flex,
      alignItems: .center,
      gap: Gap(row: 0.25.rem, column: 0.25.rem),
      padding: Padding.symmetric(vertical: 0.375.rem, horizontal: 0.5.rem),
      radius: BorderRadius.circular(0.5.rem),
      border: Border.all(width: 1.px, color: borderColor),
    ),
    css('.locale-btn').styles(
      fontSize: 0.75.rem,
      fontWeight: FontWeight.w600,
      padding: Padding.symmetric(vertical: 0.125.rem, horizontal: 0.375.rem),
      radius: BorderRadius.circular(0.25.rem),
      color: textMutedColor,
      raw: {'cursor': 'pointer', 'border': 'none', 'background': 'none'},
    ),
    css('.locale-btn--active').styles(
      backgroundColor: primaryColor,
      color: const Color('#ffffff'),
    ),
    css('.locale-btn:not(.locale-btn--active):hover').styles(color: textPrimaryColor),
    css('.theme-toggle').styles(
      display: .flex,
      alignItems: .center,
      justifyContent: .center,
      width: 2.25.rem,
      height: 2.25.rem,
      padding: .zero,
      radius: BorderRadius.circular(0.5.rem),
      border: Border.all(width: 1.px, color: borderColor),
      color: textSecondaryColor,
      fontSize: 1.rem,
      raw: {
        'cursor': 'pointer',
        'background': 'none',
        'transition': 'color 200ms ease, border-color 200ms ease',
      },
    ),
    css('.theme-toggle:hover').styles(
      color: textPrimaryColor,
      border: Border.all(width: 1.px, color: primaryColor),
    ),
    css('.theme-toggle__icon').styles(
      raw: {
        'display': 'none',
        'line-height': '1',
      },
    ),
    css(':root[data-theme="dark"] .theme-toggle__icon--sun').styles(raw: {'display': 'inline-block'}),
    css(':root[data-theme="light"] .theme-toggle__icon--moon').styles(raw: {'display': 'inline-block'}),
    css.media(MediaQuery.raw('(max-width: 768px)'), [
      css('.navbar__links').styles(display: .none),
    ]),
  ];
}

class NavbarState extends State<Navbar> {
  // ignore: prefer_final_fields
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Component build(BuildContext context) {
    final provider = LocaleProvider.of(context);
    final s = provider.strings;
    final locale = provider.locale;

    return nav(
      classes: 'navbar${_scrolled ? ' navbar--scrolled' : ''}',
      [
        div(classes: 'navbar__inner', [
          a(href: '#', classes: 'navbar__logo', [Component.text('Pulse')]),
          div(classes: 'navbar__links', [
            a(href: '#features', classes: 'navbar__link', [Component.text(s.navFeatures)]),
            a(href: '#demo', classes: 'navbar__link', [Component.text(s.navDemo)]),
            a(href: '#platform', classes: 'navbar__link', [Component.text(s.navPlatform)]),
          ]),
          div(classes: 'navbar__links', [
            _localeToggle(locale, provider.onLocaleChanged),
            _themeToggle(),
            AppButton(label: s.navGetStarted, href: '/app/', variant: ButtonVariant.primary),
          ]),
        ]),
      ],
    );
  }

  Component _themeToggle() {
    return button(
      classes: 'theme-toggle',
      attributes: const {'aria-label': 'Toggle theme', 'type': 'button'},
      events: {'click': (e) => toggleTheme()},
      [
        span(classes: 'theme-toggle__icon theme-toggle__icon--sun', [Component.text('☀')]),
        span(classes: 'theme-toggle__icon theme-toggle__icon--moon', [Component.text('🌙')]),
      ],
    );
  }

  Component _localeToggle(AppLocale current, void Function(AppLocale) onChange) {
    return div(classes: 'locale-toggle', [
      button(
        classes: 'locale-btn${current == AppLocale.en ? ' locale-btn--active' : ''}',
        events: {'click': (e) => onChange(AppLocale.en)},
        [Component.text('EN')],
      ),
      button(
        classes: 'locale-btn${current == AppLocale.ja ? ' locale-btn--active' : ''}',
        events: {'click': (e) => onChange(AppLocale.ja)},
        [Component.text('JA')],
      ),
    ]);
  }
}
