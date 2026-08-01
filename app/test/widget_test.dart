import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/core/di/providers.dart';
import 'package:khipu_ai/infrastructure/ai/gemma_status.dart';
import 'package:khipu_ai/main.dart';

void main() {
  testWidgets('Landing muestra el CTA sin registro', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          gemmaBootstrapProvider
              .overrideWith((ref) async => const GemmaReady()),
        ],
        child: const KhipuApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Khipu AI'), findsWidgets);
    expect(find.text('Entrar sin registro →'), findsOneWidget);
  });

  testWidgets('Entrar sin registro abre el app shell en Cursos', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          gemmaBootstrapProvider
              .overrideWith((ref) async => const GemmaReady()),
        ],
        child: const KhipuApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Entrar sin registro →'));
    await tester.pumpAndSettle();

    expect(find.text('Elige un curso'), findsOneWidget);
  });

  testWidgets('Tab Pizarra IA muestra el campo de pregunta', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          gemmaBootstrapProvider
              .overrideWith((ref) async => const GemmaReady()),
        ],
        child: const KhipuApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Entrar sin registro →'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Pizarra IA'));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
  });
}
