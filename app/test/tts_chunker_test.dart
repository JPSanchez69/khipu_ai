import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/infrastructure/voice/tts_chunker.dart';

void main() {
  group('TtsChunker', () {
    test('texto corto queda en un solo chunk', () {
      expect(TtsChunker.split('Hola mundo.'), ['Hola mundo.']);
    });

    test('parte por oraciones largas', () {
      const text =
          'Primera idea clara. Segunda idea también. Tercera cierra el bloque.';
      final chunks = TtsChunker.split(text, maxChars: 40);
      expect(chunks.length, greaterThan(1));
      expect(chunks.join(' '), contains('Primera'));
      expect(chunks.every((c) => c.length <= 50), isTrue);
    });

    test('parte párrafos si no hay puntos', () {
      const text =
          'Una frase sin punto pero con mucho texto seguido para forzar corte por tamaño máximo razonable en móviles';
      final chunks = TtsChunker.split(text, maxChars: 35);
      expect(chunks.length, greaterThan(1));
      expect(chunks.every((c) => c.isNotEmpty), isTrue);
    });

    test('ignora vacíos y colapsa espacios', () {
      expect(TtsChunker.split('   '), isEmpty);
      expect(TtsChunker.split('  Hola.  '), ['Hola.']);
    });
  });
}
