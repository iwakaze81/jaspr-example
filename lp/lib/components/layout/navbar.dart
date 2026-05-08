import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../styles/theme.dart';
import '../ui/button.dart';

class Navbar extends StatefulComponent {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => NavbarState();

  // @css はパブリッククラス/メンバーにのみ使用可能
  @css
  static List<StyleRule> get styles => [
    css('.navbar').styles(
      // Position.fixed() でオフセットをまとめて指定（top/left/right は Position の引数）
      position: Position.fixed(top: Unit.zero, left: Unit.zero, right: Unit.zero),
      zIndex: ZIndex(50),
      padding: Padding.symmetric(vertical: 1.rem, horizontal: 1.5.rem),
      transition: Transition('background', duration: const Duration(milliseconds: 300)),
    ),
    css('.navbar--scrolled').styles(
      raw: {
        'background': 'rgba(10, 10, 15, 0.85)',
        'backdrop-filter': 'blur(12px)',
        '-webkit-backdrop-filter': 'blur(12px)',
        'border-bottom': '1px solid rgba(255,255,255,0.06)',
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
    css.media(MediaQuery.raw('(max-width: 768px)'), [
      css('.navbar__links').styles(display: .none),
    ]),
  ];
}

class NavbarState extends State<Navbar> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    // スクロール検知は package:web の JS Interop で実装する
    // 例: web.window.onscroll = (web.Event _) {
    //   setState(() => _scrolled = web.window.scrollY > 50);
    // }.toJS;
    // kIsWeb フラグで browser/server を切り分けることができる
  }

  @override
  Component build(BuildContext context) {
    return nav(
      classes: 'navbar${_scrolled ? ' navbar--scrolled' : ''}',
      [
        div(classes: 'navbar__inner', [
          a(href: '#', classes: 'navbar__logo', [text('Pulse')]),
          div(classes: 'navbar__links', [
            a(href: '#features', classes: 'navbar__link', [text('Features')]),
            a(href: '#demo', classes: 'navbar__link', [text('Live Demo')]),
            a(href: '#platform', classes: 'navbar__link', [text('Platform')]),
          ]),
          const AppButton(label: 'Get Started', href: '/jaspr-example/app/', variant: ButtonVariant.primary),
        ]),
      ],
    );
  }
}
