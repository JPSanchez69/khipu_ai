import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/navigation_providers.dart';
import '../../core/theme/khipu_colors.dart';
import '../../core/theme/khipu_text_styles.dart';
import '../../core/theme/khipu_theme.dart';
import '../../core/widgets/khipu_button.dart';
import '../../core/widgets/khipu_mark.dart';

/// Landing sin registro. Unico punto de entrada a [AppView.app]: el
/// sidebar del app shell nunca se renderiza mientras estamos aca.
/// Ver spec de frontend seccion 1 y 4.1.
class LandingScreen extends ConsumerWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const KhipuMark(size: 88),
                  const SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      style: KhipuTextStyles.heading.copyWith(fontSize: 40),
                      children: [
                        const TextSpan(text: 'Khipu AI: tu tutor que '),
                        TextSpan(
                          text: 'habla y dibuja',
                          style: const TextStyle(color: KhipuColors.primary),
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aprende matemática con explicaciones habladas y una '
                    'pizarra digital, sin Internet y sin crear una cuenta.',
                    textAlign: TextAlign.center,
                    style: KhipuTextStyles.body.copyWith(
                      fontSize: 18,
                      color: KhipuColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 34),
                  SizedBox(
                    width: double.infinity,
                    child: KhipuButton.primary(
                      label: 'Entrar sin registro →',
                      onPressed: () =>
                          ref.read(appViewProvider.notifier).enterApp(),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'No pedimos correo ni contraseña. Todo funciona directo '
                    'en tu celular, sin conexión.',
                    textAlign: TextAlign.center,
                    style: KhipuTextStyles.body.copyWith(
                      fontSize: 13,
                      color: KhipuColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      _LandingTag(
                        label: '📱 100% On-Device',
                        background: KhipuColors.primary.withValues(
                          alpha: 0.12,
                        ),
                        foreground: KhipuColors.primary,
                      ),
                      _LandingTag(
                        label: '🎙️ Voz + Pizarra',
                        background: KhipuColors.secondary.withValues(
                          alpha: 0.12,
                        ),
                        foreground: KhipuColors.secondary,
                      ),
                      _LandingTag(
                        label: '🤖 Gemma 3',
                        background: KhipuColors.accent.withValues(
                          alpha: 0.16,
                        ),
                        foreground: const Color(0xFF8A6404),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LandingTag extends StatelessWidget {
  const _LandingTag({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(KhipuRadius.chip),
      ),
      child: Text(
        label,
        style: KhipuTextStyles.body.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: foreground,
        ),
      ),
    );
  }
}
