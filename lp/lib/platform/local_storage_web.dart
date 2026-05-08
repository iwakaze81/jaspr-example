import 'package:web/web.dart' as web;

String? readLocalStorage(String key) => web.window.localStorage.getItem(key);
void writeLocalStorage(String key, String value) => web.window.localStorage.setItem(key, value);
