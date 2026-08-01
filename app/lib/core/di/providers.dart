import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/ask_question.dart';
import '../../application/lesson_player.dart';
import '../../domain/lesson_script/board_state.dart';
import '../../domain/ports/teacher_ai_port.dart';
import '../../domain/ports/voice_ports.dart';
import '../../infrastructure/ai/gemma_teacher_ai.dart';
import '../../infrastructure/ai/stub_teacher_ai.dart';
import '../../infrastructure/voice/flutter_tts_service.dart';
import '../../infrastructure/voice/speech_to_text_service.dart';

/// `true` = intentar Gemma; si no hay modelo, el adapter cae a fixtures.
final useGemmaProvider =
    NotifierProvider<UseGemmaNotifier, bool>(UseGemmaNotifier.new);

class UseGemmaNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void set(bool value) => state = value;
}

final teacherAiProvider = Provider<TeacherAiPort>((ref) {
  final useGemma = ref.watch(useGemmaProvider);
  if (useGemma) {
    return GemmaTeacherAi();
  }
  return StubTeacherAi();
});

final ttsProvider = Provider<TtsPort>((ref) {
  final tts = FlutterTtsService();
  ref.onDispose(tts.dispose);
  return tts;
});

final sttProvider = Provider<SttPort>((ref) {
  final stt = SpeechToTextService();
  ref.onDispose(stt.dispose);
  return stt;
});

final askQuestionProvider = Provider<AskQuestion>((ref) {
  return AskQuestion(ref.watch(teacherAiProvider));
});

final lessonPlayerProvider = Provider<LessonPlayer>((ref) {
  return LessonPlayer(
    reducer: const BoardReducer(),
    tts: ref.watch(ttsProvider),
  );
});

final boardStateProvider =
    NotifierProvider<BoardStateNotifier, BoardState>(BoardStateNotifier.new);

class BoardStateNotifier extends Notifier<BoardState> {
  @override
  BoardState build() => const BoardState();

  void replace(BoardState next) => state = next;

  void clear() => state = const BoardState();
}

enum LessonPhase { idle, thinking, playing, error }

class LessonUiState {
  const LessonUiState({
    this.phase = LessonPhase.idle,
    this.statusMessage = 'Pregúntame algo. Te lo explico en la pizarra.',
    this.errorMessage,
    this.lessonTitle,
  });

  final LessonPhase phase;
  final String statusMessage;
  final String? errorMessage;
  final String? lessonTitle;

  LessonUiState copyWith({
    LessonPhase? phase,
    String? statusMessage,
    String? errorMessage,
    String? lessonTitle,
    bool clearError = false,
  }) {
    return LessonUiState(
      phase: phase ?? this.phase,
      statusMessage: statusMessage ?? this.statusMessage,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      lessonTitle: lessonTitle ?? this.lessonTitle,
    );
  }
}

final lessonUiProvider =
    NotifierProvider<LessonUiNotifier, LessonUiState>(LessonUiNotifier.new);

class LessonUiNotifier extends Notifier<LessonUiState> {
  @override
  LessonUiState build() => const LessonUiState();

  Future<void> ask(String question) async {
    final ask = ref.read(askQuestionProvider);
    final player = ref.read(lessonPlayerProvider);
    final board = ref.read(boardStateProvider.notifier);

    state = state.copyWith(
      phase: LessonPhase.thinking,
      statusMessage: 'Pensando cómo enseñártelo…',
      clearError: true,
    );
    board.clear();

    try {
      final script = await ask(question);
      state = state.copyWith(
        phase: LessonPhase.playing,
        lessonTitle: script.title,
        statusMessage: script.title,
      );
      await player.play(
        script,
        onBoard: board.replace,
        onStatus: (msg) {
          state = state.copyWith(statusMessage: msg);
        },
      );
      state = state.copyWith(
        phase: LessonPhase.idle,
        statusMessage: '¿Otra pregunta?',
      );
    } catch (e) {
      state = state.copyWith(
        phase: LessonPhase.error,
        errorMessage: 'No pude armar la lección. Intenta de nuevo.',
        statusMessage: 'Hubo un problema',
      );
    }
  }

  Future<void> stop() async {
    await ref.read(lessonPlayerProvider).stop();
    state = state.copyWith(
      phase: LessonPhase.idle,
      statusMessage: 'Detenido. ¿Seguimos?',
    );
  }
}
