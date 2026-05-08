import 'package:web/web.dart' as web;

const _storageKey = 'pulse-theme';

void toggleTheme() {
  final root = web.document.documentElement;
  if (root == null) return;
  final current = root.getAttribute('data-theme');
  final next = current == 'light' ? 'dark' : 'light';
  root.setAttribute('data-theme', next);
  web.window.localStorage.setItem(_storageKey, next);
}
