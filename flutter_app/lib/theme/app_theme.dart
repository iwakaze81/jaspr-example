import 'package:flutter/material.dart';

abstract class AppTheme {
  static const _seed = Color(0xFF6366F1);

  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark).copyWith(
      surface: const Color(0xFF0a0a0f),
      surfaceContainerLow: const Color(0xFF111118),
      surfaceContainer: const Color(0xFF1a1a2e),
      outline: const Color(0xFF1e1e2e),
      primary: _seed,
    ),
    scaffoldBackgroundColor: const Color(0xFF0a0a0f),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Color(0xFF111118),
      indicatorColor: Color(0xFF6366F1),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0a0a0f),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF111118),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF1e1e2e)),
      ),
    ),
  );
}
