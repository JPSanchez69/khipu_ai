import 'package:flutter/material.dart';

/// Paleta Khipu: verde andino + acento sol (sin purple AI cliché).
/// Tipografías del sistema con stacks expresivos vía fontFamily fallback.
class KhipuTheme {
  KhipuTheme._();

  static const forest = Color(0xFF1B4332);
  static const leaf = Color(0xFF2D6A4F);
  static const mint = Color(0xFF95D5B2);
  static const chalk = Color(0xFFF7F3E9);
  static const board = Color(0xFF0B3D2E);
  static const clay = Color(0xFFBC4749);
  static const sun = Color(0xFFF4A261);
  static const ink = Color(0xFF1A1A1A);

  static const _display = 'Georgia';
  static const _body = 'Verdana';

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: leaf,
        primary: forest,
        secondary: sun,
        surface: chalk,
        error: clay,
        brightness: Brightness.light,
      ),
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        fontFamily: _body,
        displayColor: forest,
        bodyColor: ink,
      ).copyWith(
        displayLarge: const TextStyle(
          fontFamily: _display,
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: forest,
        ),
        headlineMedium: const TextStyle(
          fontFamily: _display,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: forest,
        ),
        titleLarge: const TextStyle(
          fontFamily: _display,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: forest,
        ),
        titleMedium: const TextStyle(
          fontFamily: _body,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: ink,
        ),
        bodyLarge: const TextStyle(
          fontFamily: _body,
          fontSize: 16,
          height: 1.35,
          color: ink,
        ),
      ),
      scaffoldBackgroundColor: chalk,
      appBarTheme: const AppBarTheme(
        backgroundColor: chalk,
        foregroundColor: forest,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: _display,
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: forest,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: forest,
          foregroundColor: chalk,
          minimumSize: const Size(48, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: _body,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
