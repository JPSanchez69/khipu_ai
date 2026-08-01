import 'package:flutter/material.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:flutter_gemma_litertlm/flutter_gemma_litertlm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/di/navigation_providers.dart';
import 'core/theme/khipu_theme.dart';
import 'features/landing/landing_screen.dart';
import 'features/shell/app_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // LiteRT-LM para gemma-3n-E2B-it-*.litertlm (visión on-device).
  // Sin modelo instalado, GemmaTeacherAi cae a fixtures automáticamente.
  try {
    await FlutterGemma.initialize(
      inferenceEngines: [LiteRtLmEngine()],
      webStorageMode: WebStorageMode.streaming,
    );
  } catch (e) {
    debugPrint('Khipu: FlutterGemma.initialize omitido: $e');
  }

  runApp(const ProviderScope(child: KhipuApp()));
}

class KhipuApp extends ConsumerWidget {
  const KhipuApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(appViewProvider);
    return MaterialApp(
      title: 'Khipu AI',
      debugShowCheckedModeBanner: false,
      theme: KhipuTheme.light(),
      home: switch (view) {
        AppView.landing => const LandingScreen(),
        AppView.app => const AppShell(),
      },
    );
  }
}
