import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/domain/lesson_script/board_state.dart';
import 'package:khipu_ai/domain/lesson_script/lesson_action.dart';
import 'package:khipu_ai/domain/lesson_script/lesson_script_parser.dart';
import 'package:khipu_ai/infrastructure/ai/lesson_fixtures.dart';

void main() {
  group('LessonScriptParser', () {
    const parser = LessonScriptParser();

    test('parsea fixture de ecuación con ≥5 acciones', () {
      final script = LessonFixtures.equation2x();
      expect(script.schemaVersion, '0.1');
      expect(script.actions.length, greaterThanOrEqualTo(5));
      expect(
        script.actions.whereType<AskSocraticAction>(),
        isNotEmpty,
      );
      expect(
        script.actions.whereType<SpeakCueAction>(),
        isNotEmpty,
      );
    });

    test('repara JSON envuelto en markdown', () {
      const raw = '''
Aquí tienes la lección:
```json
{"schemaVersion":"0.1","title":"T","actions":[{"type":"writeText","id":"a","text":"hola","x":1,"y":2}]}
```
''';
      final script = parser.parseLenient(raw);
      expect(script.title, 'T');
      expect(script.actions, hasLength(1));
    });

    test('rechaza schema desconocido', () {
      expect(
        () => parser.parse(
          '{"schemaVersion":"9.9","title":"x","actions":[{"type":"wait","id":"w","ms":1}]}',
        ),
        throwsA(isA<LessonScriptParseException>()),
      );
    });
  });

  group('BoardReducer', () {
    const reducer = BoardReducer();

    test('write + highlight + move mantienen estado coherente', () {
      var state = const BoardState();
      state = reducer.apply(
        state,
        const WriteTextAction(id: 't1', text: '2x=8', x: 10, y: 20),
        0,
      );
      expect(state.elements, hasLength(1));
      state = reducer.apply(
        state,
        const HighlightAction(id: 'h1', targetId: 't1'),
        1,
      );
      expect(state.elements.first.highlighted, isTrue);
      state = reducer.apply(
        state,
        const MoveAction(id: 'm1', targetId: 't1', toX: 50, toY: 80),
        2,
      );
      expect(state.elements.first.x, 50);
      expect(state.elements.first.y, 80);
    });

    test('speakCue y socratic actualizan mensajes', () {
      var state = const BoardState();
      state = reducer.apply(
        state,
        const SpeakCueAction(id: 's', text: 'Hola'),
        0,
      );
      expect(state.lastSpeakCue, 'Hola');
      state = reducer.apply(
        state,
        const AskSocraticAction(id: 'q', prompt: '¿Por qué?'),
        1,
      );
      expect(state.socraticPrompt, '¿Por qué?');
    });
  });

  group('LessonFixtures.resolve', () {
    test('elige timeline para dinosaurios', () {
      final s = LessonFixtures.resolve('¿Por qué se extinguieron los dinosaurios?');
      expect(s.subject, 'ciencias');
    });

    test('elige ecuación por defecto', () {
      final s = LessonFixtures.resolve('explicame una ecuación');
      expect(s.title, contains('2x'));
    });
  });
}
