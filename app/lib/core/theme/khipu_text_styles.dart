import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'khipu_colors.dart';

/// Estilos tipograficos de Khipu AI.
/// Titulos en Baloo 2 (redondeada, amigable para ninos), cuerpo y
/// narracion en Nunito Sans. Ver `khipu_design_tokens.md` seccion 3.
class KhipuTextStyles {
  KhipuTextStyles._();

  /// Titulos / wordmark. Nunca en mayusculas sostenidas.
  static TextStyle get heading => GoogleFonts.baloo2(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: KhipuColors.textPrimary,
      );

  /// Cuerpo / UI. Tamano minimo 16sp: 14sp esta prohibido.
  static TextStyle get body => GoogleFonts.nunitoSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: KhipuColors.textPrimary,
      );

  /// Narracion de la IA en la pizarra: tamano mayor, alto contraste.
  static TextStyle get narracion => GoogleFonts.nunitoSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: KhipuColors.textPrimary,
      );
}
