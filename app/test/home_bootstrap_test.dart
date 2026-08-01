import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/core/di/providers.dart';
import 'package:khipu_ai/features/lesson/pizarra_screen.dart';
import 'package:khipu_ai/infrastructure/ai/gemma_model_installer.dart';
import 'package:khipu_ai/infrastructure/ai/gemma_status.dart';

void main() {
  testWidgets('ready: no muestra instalar desde Descargas', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          gemmaInstallerProvider.overrideWithValue(
            GemmaModelInstaller(
              resolveModelPath: () async => '/fake/model.litertlm',
              installImpl: (path, {onProgress}) async {},
            ),
          ),
          gemmaBootstrapProvider.overrideWith((ref) async => const GemmaReady()),
        ],
        child: const MaterialApp(home: Scaffold(body: PizarraScreen())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Descargas'), findsNothing);
    expect(find.textContaining('Gemma no listo'), findsNothing);
    expect(find.text('Gemma'), findsOneWidget);
  });

  testWidgets('notInstalled: onboarding sin texto Descargas obligatorio',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          gemmaBootstrapProvider
              .overrideWith((ref) async => const GemmaNotInstalled()),
        ],
        child: const MaterialApp(home: Scaffold(body: PizarraScreen())),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.textContaining('instala el .litertlm desde Descargas'),
      findsNothing,
    );
    expect(find.textContaining('push_model'), findsOneWidget);
  });

  testWidgets('failed: muestra razón', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          gemmaBootstrapProvider.overrideWith(
            (ref) async => const GemmaFailed('OOM'),
          ),
        ],
        child: const MaterialApp(home: Scaffold(body: PizarraScreen())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('OOM'), findsOneWidget);
  });
}
