import 'package:flutter/material.dart';

import 'khipu_colors.dart';

/// Degradados de marca de Khipu AI. Ver `khipu_design_tokens.md` seccion 4.
class KhipuGradients {
  KhipuGradients._();

  /// Terracota -> mostaza -> turquesa, 135°. Boton "Preguntar", banners.
  static const brand = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      KhipuColors.brandTerracota,
      KhipuColors.brandMostaza,
      KhipuColors.brandTurquesa,
    ],
  );

  /// Degradado de marca al 12% de opacidad. Fondos de tarjetas de logros.
  static final brandSoft = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      KhipuColors.brandTerracota.withValues(alpha: 0.12),
      KhipuColors.brandMostaza.withValues(alpha: 0.12),
      KhipuColors.brandTurquesa.withValues(alpha: 0.12),
    ],
  );
}
