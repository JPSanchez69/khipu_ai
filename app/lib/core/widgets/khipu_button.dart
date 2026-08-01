import 'package:flutter/material.dart';

import '../theme/khipu_colors.dart';
import '../theme/khipu_effects.dart';
import '../theme/khipu_theme.dart';

enum _KhipuButtonVariant { primary, secondary, danger, voice }

/// Boton base de Khipu AI con las variantes definidas en
/// `khipu_design_tokens.md` seccion 5.
class KhipuButton extends StatelessWidget {
  const KhipuButton._({
    required this._variant,
    required this.onPressed,
    this.label,
    this.isListening = false,
  });

  factory KhipuButton.primary({
    required String label,
    required VoidCallback? onPressed,
  }) {
    return KhipuButton._(
      variant: _KhipuButtonVariant.primary,
      label: label,
      onPressed: onPressed,
    );
  }

  factory KhipuButton.secondary({
    required String label,
    required VoidCallback? onPressed,
  }) {
    return KhipuButton._(
      variant: _KhipuButtonVariant.secondary,
      label: label,
      onPressed: onPressed,
    );
  }

  factory KhipuButton.danger({
    required String label,
    required VoidCallback? onPressed,
  }) {
    return KhipuButton._(
      variant: _KhipuButtonVariant.danger,
      label: label,
      onPressed: onPressed,
    );
  }

  factory KhipuButton.voice({
    required bool isListening,
    required VoidCallback? onPressed,
  }) {
    return KhipuButton._(
      variant: _KhipuButtonVariant.voice,
      onPressed: onPressed,
      isListening: isListening,
    );
  }

  final _KhipuButtonVariant _variant;
  final String? label;
  final VoidCallback? onPressed;
  final bool isListening;

  static final _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(KhipuRadius.button),
  );

  @override
  Widget build(BuildContext context) {
    switch (_variant) {
      case _KhipuButtonVariant.primary:
        return FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: KhipuColors.primary,
            foregroundColor: KhipuColors.surface,
            minimumSize: const Size(48, 52),
            shape: _shape,
          ),
          child: Text(label ?? ''),
        );

      case _KhipuButtonVariant.secondary:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: KhipuColors.secondary,
            side: const BorderSide(color: KhipuColors.secondary, width: 1.5),
            minimumSize: const Size(48, 52),
            shape: _shape,
          ),
          child: Text(label ?? ''),
        );

      case _KhipuButtonVariant.danger:
        return FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: KhipuColors.danger,
            foregroundColor: KhipuColors.surface,
            minimumSize: const Size(48, 52),
            shape: _shape,
          ),
          child: Text(label ?? ''),
        );

      case _KhipuButtonVariant.voice:
        final button = IconButton.filled(
          onPressed: onPressed,
          style: IconButton.styleFrom(
            backgroundColor:
                isListening ? KhipuColors.secondary : KhipuColors.surfaceMuted,
            foregroundColor:
                isListening ? KhipuColors.surface : KhipuColors.textSecondary,
            minimumSize: const Size(52, 52),
          ),
          icon: Icon(isListening ? Icons.hearing : Icons.mic),
        );
        if (!isListening) return button;
        return DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: KhipuEffects.voiceGlow,
          ),
          child: button,
        );
    }
  }
}
