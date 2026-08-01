import 'package:flutter/material.dart';

import '../../core/theme/khipu_colors.dart';
import '../../core/theme/khipu_text_styles.dart';
import '../../core/theme/khipu_theme.dart';

/// Tab "Mi progreso". Ver spec de frontend seccion 4.5.
class ProgresoScreen extends StatelessWidget {
  const ProgresoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'Mi progreso',
          style: KhipuTextStyles.heading.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 6),
        Text(
          'Lo que has avanzado esta semana.',
          style: KhipuTextStyles.body.copyWith(
            color: KhipuColors.textSecondary,
          ),
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: const [
            _StatCard(
              value: '4',
              label: 'días de racha',
              color: KhipuColors.accent,
            ),
            _StatCard(
              value: '17',
              label: 'temas completados',
              color: KhipuColors.secondary,
            ),
            _StatCard(
              value: '3',
              label: 'insignias ganadas',
              color: KhipuColors.success,
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
      decoration: BoxDecoration(
        color: KhipuColors.surface,
        borderRadius: BorderRadius.circular(KhipuRadius.card),
        border: Border.all(color: KhipuColors.border),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: KhipuTextStyles.heading.copyWith(
              fontSize: 36,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: KhipuTextStyles.body.copyWith(
              fontSize: 13,
              color: KhipuColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
