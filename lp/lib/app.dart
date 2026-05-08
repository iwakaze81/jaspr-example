import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'components/layout/footer.dart';
import 'components/layout/navbar.dart';
import 'pages/home_page.dart';

// @client によりビルド時にプリレンダリングされ、ブラウザでハイドレーションされる
@client
class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'app', [
      const Navbar(),
      const HomePage(),
      const Footer(),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.app').styles(
      display: .flex,
      flexDirection: .column,
      minHeight: 100.vh,
    ),
  ];
}
