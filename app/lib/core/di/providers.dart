import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/ask_question.dart';
import '../../application/lesson_player.dart';
import '../../domain/lesson_script/board_state.dart';
import '../../domain/ports/photo_picker_port.dart';
import '../../domain/ports/teacher_ai_port.dart';
import '../../domain/ports/voice_ports.dart';
import '../../infrastructure/ai/gemma_model_installer.dart';
import '../../infrastructure/ai/gemma_status.dart';
import '../../infrastructure/ai/gemma_teacher_ai.dart';
import '../../infrastructure/media/image_picker_photo_service.dart';
import '../../infrastructure/voice/flutter_tts_service.dart';
import '../../infrastructure/voice/speech_to_text_service.dart';

final gemmaInstallerProvider = Provider<GemmaModelInstaller>((ref) {
  return GemmaModelInstaller();
});

/// Bootstrap: registro del .task + estado del motor MediaPipe.
final gemmaBootstrapProvider = FutureProvider<GemmaStatus>((ref) async {
  final installer = ref.watch(gemmaInstallerProvider);
  final progress = ref.read(modelInstallProgressProvider.notifier);
  try {
    final status = await installer.ensureModelInstalled(
      onProgress: progress.set,
    );
    GemmaBootstrapCache.last = status;
    return status;
  } finally {
    progress.set(null);
  }
});

/// Producto: siempre Gemma. Stub solo en tests vía inyección manual.
final teacherAiProvider = Provider<TeacherAiPort>((ref) {
  ref.watch(gemmaBootstrapProvider);
  final gemma = GemmaTeacherAi();
  ref.onDispose(gemma.dispose);
  return gemma;
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

    GemmaStatus? bootStatus;
    try {
      bootStatus = await ref.read(gemmaBootstrapProvider.future);
    } catch (_) {
      bootStatus = null;
    }
    final bootHint = _bootHint(bootStatus);

    state = state.copyWith(
      phase: LessonPhase.thinking,
      statusMessage: 'Pensando cómo enseñártelo…',
      engineHint: bootHint,
      clearError: true,
    );
    board.clear();

    try {
      final result = await ask(question);
      if (result.engine != TeacherEngineKind.gemma) {
        throw const TeacherAiException(
          'Motor inesperado: se esperaba Gemma.',
        );
      }

      final hint = result.degradedReason != null
          ? 'Gemma 3 1B — ${result.degradedReason}'
          : 'Gemma 3 1B';
      state = state.copyWith(
        phase: LessonPhase.playing,
        lessonTitle: result.script.title,
        statusMessage: result.script.title,
        engineHint: hint,
        // Visible pero no bloquea la pizarra (recuperación honestamente degradada).
        errorMessage: result.degradedReason,
        clearError: result.degradedReason == null,
      );
      await player.play(
        result.script,
        onBoard: board.replace,
        onStatus: (msg) {
          state = state.copyWith(statusMessage: msg);
        },
      );
      state = state.copyWith(
        phase: LessonPhase.idle,
        statusMessage: '¿Otra pregunta?',
        engineHint: hint,
        errorMessage: result.degradedReason,
        clearError: result.degradedReason == null,
      );
    } on TeacherAiException catch (e) {
      state = state.copyWith(
        phase: LessonPhase.error,
        errorMessage: e.message,
        statusMessage: 'Gemma no pudo enseñar',
        engineHint: bootHint,
      );
    } catch (e) {
      state = state.copyWith(
        phase: LessonPhase.error,
        errorMessage:
            'No pude armar la lección en la pizarra. Intenta de nuevo.',
        statusMessage: 'Hubo un problema',
        engineHint: bootHint,
      );
    }
  }

  String _bootHint(GemmaStatus? status) {
    return switch (status) {
      GemmaReady() => 'Gemma 3 1B',
      GemmaNotInstalled() => 'Gemma no listo (sin modelo)',
      GemmaFailed(:final reason) => 'Gemma falló: $reason',
      GemmaInstalling(:final progress) => 'Instalando… $progress%',
      null => 'Preparando Gemma…',
    };
  }

  Future<void> stop() async {
    await ref.read(lessonPlayerProvider).stop();
    state = state.copyWith(
      phase: LessonPhase.idle,
      statusMessage: 'Detenido. ¿Seguimos?',
    );
  }
}
