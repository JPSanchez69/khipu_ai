import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/domain/lesson_script/lesson_action.dart';
import 'package:khipu_ai/domain/lesson_script/lesson_script_quality.dart';
import 'package:khipu_ai/infrastructure/ai/equation_lesson_builder.dart';

void main() {
  group('EquationLessonBuilder', () {
    test('2x+3=1 produce writeText con la ecuación y speakCue', () {
      final script = EquationLessonBuilder.tryBuild('2x+3=1');
      expect(script, isNotNull);
      LessonScriptQuality.ensurePlayable(script!);
      final texts =
          script.actions.whereType<WriteTextAction>().map((e) => e.text);
      expect(texts.any((t) => t.contains('2x') && t.contains('=1')), isTrue);
      expect(script.actions.whereType<SpeakCueAction>(), isNotEmpty);
    });

    test('extrae ecuación embebida', () {
      expect(
        EquationLessonBuilder.extractEquation('¿Cómo resuelvo 2x + 3 = 11?'),
        '2x+3=11',
      );
    });

    test('2x=6 no duplica el mismo texto en t1/t2', () {
      final script = EquationLessonBuilder.tryBuild('2x=6');
      expect(script, isNotNull);
      final texts = script!.actions
          .whereType<WriteTextAction>()
          .map((e) => e.text)
          .toList();
      expect(texts.first, '2x=6');
      expect(texts[1], 'x=3');
    });

    test('null si no hay ecuación lineal', () {
      expect(EquationLessonBuilder.tryBuild('explícame fracciones'), isNull);
    });
  });
}
