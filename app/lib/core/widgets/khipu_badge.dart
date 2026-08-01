import 'package:flutter/material.dart';

import '../theme/khipu_colors.dart';
import '../theme/khipu_text_styles.dart';
import '../theme/khipu_theme.dart';

/// Estado de avance de un tema en la pizarra.
enum EstadoTema { completado, enCurso, bloqueado }

/// Nivel de dificultad de un tema o evaluacion.
enum Dificultad { facil, media, dificil }

/// Badge base de Khipu AI para estados de progreso y dificultad.
/// Ver `khipu_design_tokens.md` seccion 5.
class KhipuBadge extends StatelessWidget {
  const KhipuBadge._({
    required this.label,
    required this.background,
    required this.foreground,
    this.icon,
  });

  factory KhipuBadge.estado(EstadoTema estado) {
    switch (estado) {
      case EstadoTema.completado:
        return KhipuBadge._(
          label: 'Completado',
          background: KhipuColors.success.withValues(alpha: 0.15),
          foreground: KhipuColors.success,
          icon: Icons.check_circle,
        );
      case EstadoTema.enCurso:
        return KhipuBadge._(
          label: 'En curso',
          background: KhipuColors.accent.withValues(alpha: 0.18),
          foreground: const Color(0xFF9A7A00),
          icon: Icons.autorenew,
        );
      case EstadoTema.bloqueado:
        return KhipuBadge._(
          label: 'Bloqueado',
          background: KhipuColors.textMuted.withValues(alpha: 0.15),
          foreground: KhipuColors.textSecondary,
          icon: Icons.lock,
        );
    }
  }

  factory KhipuBadge.dificultad(Dificultad dificultad) {
    switch (dificultad) {
      case Dificultad.facil:
        return KhipuBadge._(
          label: 'Facil',
          background: KhipuColors.success.withValues(alpha: 0.15),
          foreground: KhipuColors.success,
        );
      case Dificultad.media:
        return KhipuBadge._(
          label: 'Media',
          background: KhipuColors.accent.withValues(alpha: 0.18),
          foreground: const Color(0xFF9A7A00),
        );
      case Dificultad.dificil:
        return KhipuBadge._(
          label: 'Dificil',
          background: KhipuColors.danger.withValues(alpha: 0.15),
          foreground: KhipuColors.danger,
        );
    }
  }

  final String label;
  final Color background;
  final Color foreground;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(KhipuRadius.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: foreground),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: KhipuTextStyles.body.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}
