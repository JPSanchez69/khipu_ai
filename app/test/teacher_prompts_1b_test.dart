import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/domain/lesson_script/lesson_script_parser.dart';
import 'package:khipu_ai/infrastructure/ai/gemma_teacher_ai.dart';
import 'package:khipu_ai/infrastructure/ai/teacher_prompts.dart';

void main() {
  test('TeacherPrompts 1B: JSON-only, sin path de foto', () {
    expect(TeacherPrompts.system, contains('ÚNICAMENTE'));
    expect(TeacherPrompts.system, contains('speakCue'));
    expect(TeacherPrompts.system, contains('writeText'));
    expect(TeacherPrompts.system, isNot(contains('Si hay imagen')));
    expect(TeacherPrompts.userQuestion('2x+3=11'), isNot(contains('foto')));
    expect(TeacherPrompts.userQuestion(''), isNot(contains('foto')));
  });

  test('parsePlayable acepta JSON jugable y rechaza chat-only', () {
    final ai = GemmaTeacherAi();
    final ok = ai.parsePlayable('''
{"schemaVersion":"0.1","title":"T","subject":"mates","actions":[
{"type":"speakCue","id":"s1","text":"Hola"},
{"type":"writeText","id":"t1","text":"2x","x":10,"y":10}
]}
''');
    expect(ok.actions.length, 2);

    expect(
      () => ai.parsePlayable('''
{"schemaVersion":"0.1","title":"T","subject":"mates","actions":[
{"type":"speakCue","id":"s1","text":"Solo chat"}
]}
'''),
      throwsA(isA<LessonScriptParseException>()),
    );
  });
}
