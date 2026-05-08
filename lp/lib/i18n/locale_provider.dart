import 'package:jaspr/jaspr.dart';

import '../platform/local_storage_platform.dart';
import 'strings.dart';

export 'strings.dart';

class LocaleProvider extends InheritedComponent {
  const LocaleProvider({
    required this.locale,
    required this.onLocaleChanged,
    required super.child,
    super.key,
  });

  final AppLocale locale;
  final void Function(AppLocale) onLocaleChanged;

  S get strings => S(locale);

  static LocaleProvider of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<LocaleProvider>()!;
  }

  @override
  bool updateShouldNotify(LocaleProvider oldComponent) {
    return locale != oldComponent.locale;
  }
}

class LocaleController extends StatefulComponent {
  const LocaleController({required this.child, super.key});
  final Component child;

  @override
  State<LocaleController> createState() => _LocaleControllerState();
}

class _LocaleControllerState extends State<LocaleController> {
  AppLocale _locale = AppLocale.en;

  @override
  void initState() {
    super.initState();
    final stored = readLocalStorage('locale');
    if (stored == 'ja') _locale = AppLocale.ja;
  }

  void _changeLocale(AppLocale locale) {
    setState(() => _locale = locale);
    writeLocalStorage('locale', locale.name);
  }

  @override
  Component build(BuildContext context) {
    return LocaleProvider(
      locale: _locale,
      onLocaleChanged: _changeLocale,
      child: component.child,
    );
  }
}
