import 'package:flutter/material.dart';

import '../theme/khipu_colors.dart';
import '../theme/khipu_text_styles.dart';
import '../theme/khipu_theme.dart';

/// Tarjeta base de Khipu AI. Ver `khipu_design_tokens.md` seccion 5.
class KhipuCard extends StatelessWidget {
  const KhipuCard({
    super.key,
    required this.title,
    this.subtitle,
    this.child,
    this.footer,
  });

  final String title;
  final String? subtitle;
  final Widget? child;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: KhipuColors.surface,
        borderRadius: BorderRadius.circular(KhipuRadius.card),
        border: Border.all(color: KhipuColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: KhipuTextStyles.heading.copyWith(fontSize: 18)),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: KhipuTextStyles.body.copyWith(
                color: KhipuColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
          if (child != null) ...[
            const SizedBox(height: 12),
            child!,
          ],
          if (footer != null) ...[
            const SizedBox(height: 12),
            footer!,
          ],
        ],
      ),
    );
  }
}
