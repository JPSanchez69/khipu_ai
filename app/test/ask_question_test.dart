import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/application/ask_question.dart';
import 'package:khipu_ai/domain/ports/teacher_ai_port.dart';
import 'package:khipu_ai/infrastructure/ai/stub_teacher_ai.dart';
import 'package:khipu_ai/infrastructure/voice/tts_chunker.dart';

void main() {
  group('AskQuestion', () {
    final ask = AskQuestion(StubTeacherAi());

    test('rechaza vacío sin foto', () {
      expect(() => ask(''), throwsA(isA<ArgumentError>()));
    });

    test('acepta solo foto', () async {
      final script = await ask('', imageJpeg: Uint8List.fromList([1, 2, 3]));
      expect(script.actions, isNotEmpty);
    });

    test('acepta pregunta de texto', () async {
      final script = await ask('¿Cómo resuelvo 2x + 3 = 11?');
      expect(script.title, contains('2x'));
    });
  });

  group('TeachRequest', () {
    test('hasImage respeta bytes vacíos', () {
      expect(
        const TeachRequest(question: 'x', imageJpeg: null).hasImage,
        isFalse,
      );
      expect(
        TeachRequest(question: 'x', imageJpeg: Uint8List(0)).hasImage,
        isFalse,
      );
    });
  });

  group('TtsChunker smoke', () {
    test('oraciones múltiples', () {
      final c = TtsChunker.split('Uno. Dos. Tres.', maxChars: 8);
      expect(c.length, greaterThanOrEqualTo(2));
    });
  });
}
