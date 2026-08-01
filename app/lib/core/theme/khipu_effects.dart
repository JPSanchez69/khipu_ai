import 'package:flutter/material.dart';

import 'khipu_colors.dart';

/// Efectos visuales de "IA hablando / escuchando" de Khipu AI.
/// Ver `khipu_design_tokens.md` seccion 4.
class KhipuEffects {
  KhipuEffects._();

  /// Sombra suave turquesa alrededor del boton de microfono cuando
  /// la IA esta escuchando al estudiante.
  static List<BoxShadow> get voiceGlow => [
        BoxShadow(
          color: KhipuColors.secondary.withValues(alpha: 0.45),
          blurRadius: 20,
          spreadRadius: 4,
        ),
      ];

  /// Envuelve [child] con un pulso suave en mostaza, para cuando
  /// Gemma esta generando el guion ("profesor pensando").
  static Widget thinkingPulse({required Widget child}) {
    return _ThinkingPulse(child: child);
  }

  /// Envuelve [child] con un subrayado animado terracota, usado para
  /// sincronizar la narracion con la palabra que se esta leyendo.
  static Widget narratingUnderline({
    required Widget child,
    required bool active,
  }) {
    return _NarratingUnderline(active: active, child: child);
  }
}

class _ThinkingPulse extends StatefulWidget {
  const _ThinkingPulse({required this.child});

  final Widget child;

  @override
  State<_ThinkingPulse> createState() => _ThinkingPulseState();
}

class _ThinkingPulseState extends State<_ThinkingPulse>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final t = Curves.easeInOut.transform(_controller.value);
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: KhipuColors.accent.withValues(alpha: 0.25 + t * 0.25),
                blurRadius: 8 + t * 10,
                spreadRadius: t * 3,
              ),
            ],
          ),
          child: child,
        );
      },
    );
  }
}

class _NarratingUnderline extends StatelessWidget {
  const _NarratingUnderline({required this.active, required this.child});

  final bool active;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: active ? KhipuColors.primary : Colors.transparent,
            width: 3,
          ),
        ),
      ),
      child: child,
    );
  }
}
