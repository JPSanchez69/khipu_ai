import 'package:flutter/material.dart';

import 'khipu_colors.dart';
import 'khipu_text_styles.dart';

/// Radios de borde estandar de Khipu AI.
class KhipuRadius {
  KhipuRadius._();

  static const chip = 999.0;
  static const button = 16.0;
  static const input = 18.0;
  static const card = 14.0;
  static const board = 24.0;
  static const sm = 8.0;
}

/// `ThemeData` central de Khipu AI: arma el `ColorScheme` de Flutter a
/// partir de los tokens en [KhipuColors] y [KhipuTextStyles].
/// Ver `khipu_design_tokens.md` seccion 1 y 7.
class KhipuTheme {
  KhipuTheme._();

  // --- Alias legacy para compatibilidad con pantallas aun no migradas
  // a los tokens Khipu (WhiteboardCanvas, HomeScreen). No usar en
  // codigo nuevo: preferir KhipuColors.* ---
  @Deprecated('Usar KhipuColors.brandIndigo o textPrimary')
  static const forest = Color(0xFF1B4332);
  @Deprecated('Usar KhipuColors.success')
  static const leaf = Color(0xFF2D6A4F);
  @Deprecated('Usar KhipuColors.secondary')
  static const mint = Color(0xFF95D5B2);
  @Deprecated('Usar KhipuColors.background')
  static const chalk = Color(0xFFF7F3E9);
  @Deprecated('Usar KhipuColors.pizarraTrazoPrimario')
  static const board = Color(0xFF0B3D2E);
  @Deprecated('Usar KhipuColors.danger')
  static const clay = Color(0xFFBC4749);
  @Deprecated('Usar KhipuColors.accent')
  static const sun = Color(0xFFF4A261);
  @Deprecated('Usar KhipuColors.textPrimary')
  static const ink = Color(0xFF1A1A1A);

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: KhipuColors.primary,
        onPrimary: KhipuColors.surface,
        secondary: KhipuColors.secondary,
        onSecondary: KhipuColors.surface,
        tertiary: KhipuColors.accent,
        onTertiary: KhipuColors.textPrimary,
        surface: KhipuColors.surface,
        onSurface: KhipuColors.textPrimary,
        error: KhipuColors.danger,
        onError: KhipuColors.surface,
        outline: KhipuColors.border,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: KhipuColors.background,
      textTheme: base.textTheme
          .apply(
            bodyColor: KhipuColors.textPrimary,
            displayColor: KhipuColors.textPrimary,
          )
          .copyWith(
            displayLarge: KhipuTextStyles.heading.copyWith(fontSize: 40),
            headlineMedium: KhipuTextStyles.heading.copyWith(fontSize: 28),
            titleLarge: KhipuTextStyles.heading,
            titleMedium: KhipuTextStyles.body.copyWith(
              fontWeight: FontWeight.w700,
            ),
            bodyLarge: KhipuTextStyles.body,
            bodyMedium: KhipuTextStyles.body.copyWith(
              color: KhipuColors.textSecondary,
            ),
            labelLarge: KhipuTextStyles.body.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: KhipuColors.background,
        foregroundColor: KhipuColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: KhipuTextStyles.heading.copyWith(fontSize: 26),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: KhipuColors.primary,
          foregroundColor: KhipuColors.surface,
          minimumSize: const Size(48, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KhipuRadius.button),
          ),
          textStyle: KhipuTextStyles.body.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: KhipuColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KhipuRadius.card),
          side: const BorderSide(color: KhipuColors.border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: KhipuColors.surfaceMuted,
        hintStyle: KhipuTextStyles.body.copyWith(
          color: KhipuColors.textMuted,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KhipuRadius.input),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KhipuRadius.input),
          borderSide: const BorderSide(color: KhipuColors.focusRing, width: 2),
        ),
      ),
    );
  }
}
