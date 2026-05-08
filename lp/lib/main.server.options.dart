// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:lp/components/layout/footer.dart' as _footer;
import 'package:lp/components/layout/navbar.dart' as _navbar;
import 'package:lp/components/sections/cta_section.dart' as _cta_section;
import 'package:lp/components/sections/features_section.dart'
    as _features_section;
import 'package:lp/components/sections/flutter_demo_section.dart'
    as _flutter_demo_section;
import 'package:lp/components/sections/hero_section.dart' as _hero_section;
import 'package:lp/components/sections/platform_section.dart'
    as _platform_section;
import 'package:lp/components/sections/testimonials_section.dart'
    as _testimonials_section;
import 'package:lp/components/ui/badge.dart' as _badge;
import 'package:lp/components/ui/button.dart' as _button;
import 'package:lp/components/ui/section_wrapper.dart' as _section_wrapper;
import 'package:lp/pages/home_page.dart' as _home_page;
import 'package:lp/app.dart' as _app;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {_app.App: ClientTarget<_app.App>('app')},
  styles: () => [
    ..._app.App.styles,
    ..._footer.Footer.styles,
    ..._navbar.Navbar.styles,
    ..._cta_section.CtaSection.styles,
    ..._features_section.FeaturesSection.styles,
    ..._flutter_demo_section.FlutterDemoSection.styles,
    ..._hero_section.HeroSection.styles,
    ..._platform_section.PlatformSection.styles,
    ..._testimonials_section.TestimonialsSection.styles,
    ..._badge.Badge.styles,
    ..._button.AppButton.styles,
    ..._section_wrapper.SectionWrapper.styles,
    ..._home_page.HomePage.styles,
  ],
);
