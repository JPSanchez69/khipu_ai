import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/application/ask_question.dart';
import 'package:khipu_ai/application/lesson_player.dart';
import 'package:khipu_ai/core/di/providers.dart';
import 'package:khipu_ai/domain/lesson_script/board_state.dart';
import 'package:khipu_ai/domain/lesson_script/lesson_action.dart';
import 'package:khipu_ai/domain/ports/teacher_ai_port.dart';
import 'package:khipu_ai/domain/ports/voice_ports.dart';

class _FailingTeacher implements TeacherAiPort {
  @override
  TeacherEngineKind get kind => TeacherEngineKind.gemma;

  @override
  Future<bool> isReady() async => false;

  @override
  Future<LessonResult> teach(TeachRequest request) async {
    throw const TeacherAiException('Gemma no está listo (test)');
  }
}

class _OkTeacher implements TeacherAiPort {
  @override
  TeacherEngineKind get kind => TeacherEngineKind.gemma;

  @override
  Future<bool> isReady() async => true;

  @override
  Future<LessonResult> teach(TeachRequest request) async {
    return const LessonResult(
      script: LessonScript(
        schemaVersion: '0.1',
        title: 'Lección Gemma',
        subject: 'math',
        actions: [
          WriteTextAction(id: 'w1', text: '2x=8', x: 40, y: 80),
          SpeakCueAction(id: 's1', text: 'Listo'),
        ],
      ),
      engine: TeacherEngineKind.gemma,
    );
  }
}

class _SilentTts implements TtsPort {
  @override
  Future<void> speak(String text) async {}

  @override
  Future<void> stop() async {}

  @override
  Future<void> dispose() async {}
}

void main() {
  test('TeacherAiException expone mensaje UI', () {
    const e = TeacherAiException('Gemma falló', cause: 'oom');
    expect(e.message, 'Gemma falló');
    expect(e.cause, 'oom');
  });

  test('LessonUiNotifier: fallo Gemma no reproduce ni llena pizarra', () async {
    final container = ProviderContainer(
      overrides: [
        teacherAiProvider.overrideWithValue(_FailingTeacher()),
        askQuestionProvider.overrideWithValue(AskQuestion(_FailingTeacher())),
        ttsProvider.overrideWithValue(_SilentTts()),
        lessonPlayerProvider.overrideWithValue(
          LessonPlayer(reducer: const BoardReducer(), tts: _SilentTts()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(lessonUiProvider.notifier).ask('2x+3=11');

    final ui = container.read(lessonUiProvider);
    final board = container.read(boardStateProvider);

    expect(ui.phase, LessonPhase.error);
    expect(ui.errorMessage, contains('Gemma no está listo'));
    expect(ui.engineHint, 'Gemma');
    expect(board.elements, isEmpty);
  });

  test('LessonUiNotifier: éxito solo con engine gemma', () async {
    final teacher = _OkTeacher();
    final container = ProviderContainer(
      overrides: [
        teacherAiProvider.overrideWithValue(teacher),
        askQuestionProvider.overrideWithValue(AskQuestion(teacher)),
        ttsProvider.overrideWithValue(_SilentTts()),
        lessonPlayerProvider.overrideWithValue(
          LessonPlayer(reducer: const BoardReducer(), tts: _SilentTts()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(lessonUiProvider.notifier).ask('2x+3=11');

    final ui = container.read(lessonUiProvider);
    expect(ui.phase, LessonPhase.idle);
    expect(ui.engineHint, 'Gemma E2B');
    expect(ui.errorMessage, isNull);
    expect(container.read(boardStateProvider).elements, isNotEmpty);
  });
}
