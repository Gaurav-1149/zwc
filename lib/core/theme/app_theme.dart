import 'package:flutter/material.dart';

class AppTheme {
  static const seed = Color(0xFF1B8F5A);
  static const mint = Color(0xFFE8F7EF);
  static const leaf = Color(0xFF2EB67D);
  static const ocean = Color(0xFF297EA6);
  static const amber = Color(0xFFF6B44B);

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
      primary: seed,
      secondary: ocean,
      tertiary: amber,
      surface: const Color(0xFFFAFCF8),
    );
    return _base(colorScheme);
  }

  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: leaf,
      brightness: Brightness.dark,
      primary: leaf,
      secondary: const Color(0xFF65C7E8),
      tertiary: amber,
      surface: const Color(0xFF101914),
    );
    return _base(colorScheme);
  }

  static ThemeData _base(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: colorScheme.surfaceContainerHighest.withOpacity(0.65),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.45),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
