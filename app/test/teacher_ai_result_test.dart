import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/application/ask_question.dart';
import 'package:khipu_ai/domain/lesson_script/lesson_action.dart';
import 'package:khipu_ai/domain/ports/teacher_ai_port.dart';
import 'package:khipu_ai/infrastructure/ai/stub_teacher_ai.dart';

class _CaptureTeacher implements TeacherAiPort {
  TeachRequest? last;

  @override
  TeacherEngineKind get kind => TeacherEngineKind.gemma;

  @override
  Future<bool> isReady() async => true;

  @override
  Future<LessonResult> teach(TeachRequest request) async {
    last = request;
    return LessonResult(
      script: const LessonScript(
        schemaVersion: '0.1',
        title: 'Capturado',
        subject: 'test',
        actions: [
          SpeakCueAction(id: 's1', text: 'ok'),
        ],
      ),
      engine: TeacherEngineKind.gemma,
    );
  }
}

void main() {
  group('AskQuestion + LessonResult', () {
    test('StubTeacherAi (doble unitario) marca engine stub', () async {
      final result = await AskQuestion(StubTeacherAi()).call('hola');
      expect(result.engine, TeacherEngineKind.stub);
      expect(result.degradedReason, isNotNull);
      expect(result.script.actions, isNotEmpty);
    });

    test('propaga imageJpeg al puerto', () async {
      final capture = _CaptureTeacher();
      final bytes = Uint8List.fromList([9, 8, 7]);
      final result = await AskQuestion(capture).call(
        'mira',
        imageJpeg: bytes,
      );
      expect(result.engine, TeacherEngineKind.gemma);
      expect(capture.last?.hasImage, isTrue);
      expect(capture.last?.imageJpeg, bytes);
    });

    test('acepta solo foto', () async {
      final result = await AskQuestion(StubTeacherAi()).call(
        '',
        imageJpeg: Uint8List.fromList([1, 2, 3]),
      );
      expect(result.script.actions, isNotEmpty);
    });
  });
}
