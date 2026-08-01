import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/ask_question.dart';
import '../../application/lesson_player.dart';
import '../../domain/lesson_script/board_state.dart';
import '../../domain/ports/photo_picker_port.dart';
import '../../domain/ports/teacher_ai_port.dart';
import '../../domain/ports/voice_ports.dart';
import '../../infrastructure/ai/gemma_model_installer.dart';
import '../../infrastructure/ai/gemma_teacher_ai.dart';
import '../../infrastructure/ai/stub_teacher_ai.dart';
import '../../infrastructure/media/image_picker_photo_service.dart';
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

final gemmaInstallerProvider = Provider<GemmaModelInstaller>((ref) {
  return const GemmaModelInstaller();
});

final teacherAiProvider = Provider<TeacherAiPort>((ref) {
  final useGemma = ref.watch(useGemmaProvider);
  if (useGemma) {
    final gemma = GemmaTeacherAi();
    ref.onDispose(gemma.dispose);
    return gemma;
  }
  return StubTeacherAi();
});

final photoPickerProvider = Provider<PhotoPickerPort>((ref) {
  return ImagePickerPhotoService();
});

final attachedImageProvider =
    NotifierProvider<AttachedImageNotifier, Uint8List?>(
  AttachedImageNotifier.new,
);

class AttachedImageNotifier extends Notifier<Uint8List?> {
  @override
  Uint8List? build() => null;

  void set(Uint8List? bytes) => state = bytes;

  void clear() => state = null;
}

final modelInstallProgressProvider =
    NotifierProvider<ModelInstallProgressNotifier, int?>(
  ModelInstallProgressNotifier.new,
);

class ModelInstallProgressNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? value) => state = value;
}

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
    this.engineHint,
  });

  final LessonPhase phase;
  final String statusMessage;
  final String? errorMessage;
  final String? lessonTitle;
  final String? engineHint;

  LessonUiState copyWith({
    LessonPhase? phase,
    String? statusMessage,
    String? errorMessage,
    String? lessonTitle,
    String? engineHint,
    bool clearError = false,
  }) {
    return LessonUiState(
      phase: phase ?? this.phase,
      statusMessage: statusMessage ?? this.statusMessage,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      lessonTitle: lessonTitle ?? this.lessonTitle,
      engineHint: engineHint ?? this.engineHint,
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
    final image = ref.read(attachedImageProvider);
    final useGemma = ref.read(useGemmaProvider);
    final teacher = ref.read(teacherAiProvider);

    final ready = useGemma ? await teacher.isReady() : true;
    final hint = !useGemma
        ? 'Stub'
        : (ready ? 'Gemma E2B' : 'Gemma (sin modelo → fixtures)');

    state = state.copyWith(
      phase: LessonPhase.thinking,
      statusMessage: 'Pensando cómo enseñártelo…',
      engineHint: hint,
      clearError: true,
    );
    board.clear();

    try {
      final script = await ask(question, imageJpeg: image);
      ref.read(attachedImageProvider.notifier).clear();
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
      ref.read(attachedImageProvider.notifier).clear();
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
