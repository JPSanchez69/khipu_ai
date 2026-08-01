import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/infrastructure/voice/stt_locale.dart';

void main() {
  group('pickSpanishLocaleId', () {
    test('prefiere es_US si no hay es_ES', () {
      final id = pickSpanishLocaleId(['en_US', 'es_US', 'fr_FR']);
      expect(id, 'es_US');
    });

    test('prefiere es_PE sobre es_MX', () {
      final id = pickSpanishLocaleId(['es_MX', 'es_PE', 'es_ES']);
      expect(id, 'es_PE');
    });

    test('lista vacía cae a systemLocale', () {
      final id = pickSpanishLocaleId([], systemLocaleId: 'es_PE');
      expect(id, 'es_PE');
    });

    test('cualquier es_* si no hay preferidos', () {
      final id = pickSpanishLocaleId(['en_US', 'es_AR']);
      expect(id, 'es_AR');
    });
  });
}
