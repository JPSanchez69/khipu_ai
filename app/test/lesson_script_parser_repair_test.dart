import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/domain/lesson_script/lesson_script_parser.dart';

void main() {
  const parser = LessonScriptParser();

  const minimalJson = '''
{"schemaVersion":"0.1","title":"T","subject":"mates","actions":[
{"type":"speakCue","id":"s1","text":"Hola"},
{"type":"writeText","id":"t1","text":"2x","x":10,"y":10}
]}
''';

  test('parseLenient con fences markdown', () {
    final raw = 'Aquí va:\n```json\n$minimalJson\n```\nfin';
    final script = parser.parseLenient(raw);
    expect(script.title, 'T');
    expect(script.actions.length, greaterThanOrEqualTo(2));
  });

  test('parseLenient con prosa antes/después', () {
    final raw = 'Claro, te ayudo.\n$minimalJson\n¿Seguimos?';
    final script = parser.parseLenient(raw);
    expect(script.title, 'T');
  });

  test('parseLenient con coma final', () {
    const raw = '''
{"schemaVersion":"0.1","title":"T","subject":"mates","actions":[
{"type":"speakCue","id":"s1","text":"Hola",},
{"type":"writeText","id":"t1","text":"2x","x":10,"y":10,},
],}
''';
    final script = parser.parseLenient(raw);
    expect(script.actions.length, 2);
  });

  test('parseLenient ignora acción desconocida', () {
    const raw = '''
{"schemaVersion":"0.1","title":"T","subject":"mates","actions":[
{"type":"unknownThing","id":"u1"},
{"type":"speakCue","id":"s1","text":"Ok"}
]}
''';
    final script = parser.parseLenient(raw);
    expect(script.actions.length, 1);
  });
}
