import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/sections/cta_section.dart';
import '../components/sections/features_section.dart';
import '../components/sections/flutter_demo_section.dart';
import '../components/sections/hero_section.dart';
import '../components/sections/platform_section.dart';
import '../components/sections/testimonials_section.dart';

class HomePage extends StatelessComponent {
  const HomePage({super.key});

  @override
  Component build(BuildContext context) {
    return main_(classes: 'home', [
      const HeroSection(),
      const FeaturesSection(),
      const FlutterDemoSection(),
      const PlatformSection(),
      const TestimonialsSection(),
      const CtaSection(),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.home').styles(flex: Flex(grow: 1, shrink: 0, basis: .auto)),
  ];
}
