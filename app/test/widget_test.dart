import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khipu_ai/main.dart';

void main() {
  testWidgets('Home muestra marca Khipu y campo de pregunta', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: KhipuApp()));
    await tester.pumpAndSettle();

    expect(find.text('Khipu'), findsOneWidget);
    expect(find.textContaining('sin internet'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
