import 'package:flutter/material.dart';

/// Tokens de color de Khipu AI. Unica fuente de verdad para colores:
/// prohibido hardcodear valores hexadecimales en widgets.
/// Ver `khipu_design_tokens.md` seccion 2.
class KhipuColors {
  KhipuColors._();

  // --- Base de interfaz ---
  static const background = Color(0xFFFFF8F0);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceMuted = Color(0xFFF3EAE0);
  static const textPrimary = Color(0xFF2B2118);
  static const textSecondary = Color(0xFF7A6A5D);
  static const textMuted = Color(0xFFA79A8C);
  static const border = Color(0xFFE8DED2);
  static const focusRing = Color(0xFF2FA89E);

  // --- Marca (brand) ---
  static const primary = Color(0xFFE85D2F);
  static const secondary = Color(0xFF2FA89E);
  static const accent = Color(0xFFF2B705);
  static const danger = Color(0xFFD93340);
  static const success = Color(0xFF4CAF6D);

  // --- Paleta extendida "textil andino" ---
  static const brandTerracota = Color(0xFFE85D2F);
  static const brandTurquesa = Color(0xFF2FA89E);
  static const brandMostaza = Color(0xFFF2B705);
  static const brandIndigo = Color(0xFF2C3E66);
  static const brandCrema = Color(0xFFFFF8F0);
  static const brandArena = Color(0xFFF3EAE0);

  // --- Pizarra (estados academicos) ---
  static const pizarraBg = Color(0xFFFFFFFF);
  static const pizarraBorder = Color(0xFFE8DED2);
  static const pizarraTrazoPrimario = Color(0xFF2B2118);
  static const pizarraAcento = Color(0xFFE85D2F);
}
