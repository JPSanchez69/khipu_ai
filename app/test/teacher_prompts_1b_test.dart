import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/domain/lesson_script/lesson_script_parser.dart';
import 'package:khipu_ai/infrastructure/ai/gemma_teacher_ai.dart';
import 'package:khipu_ai/infrastructure/ai/teacher_prompts.dart';

void main() {
  test('TeacherPrompts 1B: JSON-only, sin path de foto', () {
    expect(TeacherPrompts.system, contains('SOLO JSON'));
    expect(TeacherPrompts.system, contains('speakCue'));
    expect(TeacherPrompts.system, contains('writeText'));
    expect(TeacherPrompts.system, isNot(contains('Si hay imagen')));
    expect(TeacherPrompts.userQuestion('2x+3=11'), isNot(contains('foto')));
    expect(TeacherPrompts.userQuestion(''), isNot(contains('foto')));
  });

  test('system exige copiar enunciado y evita speakCue vacío genérico', () {
    expect(TeacherPrompts.system.toLowerCase(), contains('enunciado'));
    expect(TeacherPrompts.system.toLowerCase(), contains('copiar'));
    expect(
      TeacherPrompts.system.toLowerCase(),
      contains('miremos el problema'),
    );
    expect(TeacherPrompts.system, contains('highlight'));
    expect(TeacherPrompts.system, contains('SHOT A'));
    expect(TeacherPrompts.system, contains('SHOT B'));
  });

  test('userQuestion normaliza ecuación desnuda 2x+3=1', () {
    final u = TeacherPrompts.userQuestion('2x+3=1');
    expect(u.toLowerCase(), contains('resolver'));
    expect(u, contains('2x+3=1'));
    expect(u.toLowerCase(), contains('checklist'));
    expect(TeacherPrompts.looksLikeEquation('2x+3=1'), isTrue);
  });

  test('userQuestion incluye checklist y la pregunta del alumno', () {
    final u = TeacherPrompts.userQuestion('¿Cómo resuelvo 2x + 3 = 11?');
    expect(u, contains('2x + 3 = 11'));
    expect(u.toLowerCase(), contains('checklist'));
    expect(u, contains('writeText'));
    expect(u, contains('speakCue'));
    expect(u, contains('highlight'));
  });

  test('retryHint pide JSON cerrado y ecuación en writeText', () {
    final r = TeacherPrompts.retryHint.toLowerCase();
    expect(r, contains('completo'));
    expect(r, contains('writetext'));
    expect(r, contains('highlight'));
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
