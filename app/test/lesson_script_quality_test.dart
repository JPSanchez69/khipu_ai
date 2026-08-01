import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/domain/lesson_script/lesson_action.dart';
import 'package:khipu_ai/domain/lesson_script/lesson_script_parser.dart';
import 'package:khipu_ai/domain/lesson_script/lesson_script_quality.dart';

void main() {
  const parser = LessonScriptParser();

  group('LessonScriptQuality.ensurePlayable', () {
    test('acepta speakCue + writeText', () {
      final script = parser.parseLenient('''
{"schemaVersion":"0.1","title":"Ok","subject":"mates","actions":[
{"type":"speakCue","id":"s1","text":"Miremos"},
{"type":"writeText","id":"t1","text":"2x+3=11","x":40,"y":40}
]}
''');
      expect(() => LessonScriptQuality.ensurePlayable(script), returnsNormally);
    });

    test('rechaza solo speakCue (sin pizarra)', () {
      final script = parser.parseLenient('''
{"schemaVersion":"0.1","title":"Chat","subject":"mates","actions":[
{"type":"speakCue","id":"s1","text":"Hola"}
]}
''');
      expect(
        () => LessonScriptQuality.ensurePlayable(script),
        throwsA(isA<LessonScriptParseException>()),
      );
    });

    test('rechaza solo writeText (sin voz)', () {
      final script = parser.parseLenient('''
{"schemaVersion":"0.1","title":"Mudo","subject":"mates","actions":[
{"type":"writeText","id":"t1","text":"2x","x":10,"y":10}
]}
''');
      expect(
        () => LessonScriptQuality.ensurePlayable(script),
        throwsA(isA<LessonScriptParseException>()),
      );
    });
  });

  group('parseLenient estilo 1B', () {
    test('JSON truncado falla de forma visible', () {
      const truncated = '''
{"schemaVersion":"0.1","title":"T","subject":"mates","actions":[
{"type":"speakCue","id":"s1","text":"Hola"},
{"type":"writeText","id":"t1","text":"2x+3
''';
      expect(
        () => parser.parseLenient(truncated),
        throwsA(isA<LessonScriptParseException>()),
      );
    });

    test('fences + trailing commas siguen parseando lección jugable', () {
      const raw = '''
Aquí tienes:
```json
{"schemaVersion":"0.1","title":"Álgebra","subject":"mates","actions":[
{"type":"speakCue","id":"s1","text":"Miremos el problema",},
{"type":"writeText","id":"t1","text":"2x+3=11","x":40,"y":40,"fontSize":22,},
{"type":"highlight","id":"h1","targetId":"t1",},
],}
```
''';
      final script = parser.parseLenient(raw);
      LessonScriptQuality.ensurePlayable(script);
      expect(script.actions.whereType<WriteTextAction>(), isNotEmpty);
      expect(script.actions.whereType<SpeakCueAction>(), isNotEmpty);
    });
  });
}
