import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/ask_question.dart';
import '../../application/lesson_player.dart';
import '../../domain/lesson_script/board_state.dart';
import '../../domain/lesson_script/lesson_script_codec.dart';
import '../../domain/ports/photo_picker_port.dart';
import '../../domain/ports/teacher_ai_port.dart';
import '../../domain/ports/voice_ports.dart';
import '../../infrastructure/ai/gemma_model_installer.dart';
import '../../infrastructure/ai/gemma_teacher_ai.dart';
import '../../infrastructure/ai/stub_teacher_ai.dart';
import '../../infrastructure/media/image_picker_photo_service.dart';
import '../../infrastructure/database/khipu_database.dart';
import 'navigation_providers.dart';
import '../../infrastructure/voice/flutter_tts_service.dart';
import '../../infrastructure/voice/speech_to_text_service.dart';

/// `true` = intentar Gemma; si no hay modelo, el adapter cae a fixtures.
final useGemmaProvider = NotifierProvider<UseGemmaNotifier, bool>(
  UseGemmaNotifier.new,
);

class UseGemmaNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void set(bool value) => state = value;
}

final databaseProvider = Provider<KhipuDatabase>((ref) {
  final database = KhipuDatabase();
  ref.onDispose(database.close);
  return database;
});

final studentProfileProvider = StreamProvider<StudentProfileRow>((ref) {
  return ref.watch(databaseProvider).watchProfile();
});

final responseDetailProvider =
    NotifierProvider<ResponseDetailNotifier, ResponseDetail>(
      ResponseDetailNotifier.new,
    );

class ResponseDetailNotifier extends Notifier<ResponseDetail> {
  @override
  ResponseDetail build() => ResponseDetail.standard;
  void set(ResponseDetail detail) {
    state = detail;
    ref.read(databaseProvider).updateDefaultResponseDetail(detail.name);
  }
}

final activeChatIdProvider = NotifierProvider<ActiveChatIdNotifier, String?>(
  ActiveChatIdNotifier.new,
);

class ActiveChatIdNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  void set(String? id) => state = id;
}

final activeChatTurnsProvider = StreamProvider<List<ChatTurnRow>>((ref) {
  final id = ref.watch(activeChatIdProvider);
  if (id == null) return Stream.value(const []);
  return ref.watch(databaseProvider).watchTurns(id);
});

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
  ref.read(databaseProvider).getProfile().then((profile) {
    return tts.configure(
      name: profile.voiceName,
      locale: profile.voiceLocale,
      rate: profile.speechRate,
      pitch: profile.speechPitch,
    );
  });
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

final boardStateProvider = NotifierProvider<BoardStateNotifier, BoardState>(
  BoardStateNotifier.new,
);

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

final lessonUiProvider = NotifierProvider<LessonUiNotifier, LessonUiState>(
  LessonUiNotifier.new,
);

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
    final database = ref.read(databaseProvider);
    final profile = await database.getProfile();
    final detail = ref.read(responseDetailProvider);
    final courseTitle = ref.read(pizarraContextProvider);
    final course = await database.courseForTitle(courseTitle);
    var topic = course.title.contains('·')
        ? course.title.split('·').last.trim()
        : course.title;
    var notebook = await database.ensureNotebookForCourse(
      course.id,
      title: 'Mi cuaderno de $topic',
      topic: topic,
    );
    var chatId = ref.read(activeChatIdProvider);
    if (chatId == null) {
      final chat = await database.createChat(
        notebook.id,
        question.trim().isEmpty ? 'Ejercicio con imagen' : question.trim(),
      );
      chatId = chat.id;
      ref.read(activeChatIdProvider.notifier).set(chatId);
    } else {
      final activeChat = await database.getChat(chatId);
      notebook = await database.getNotebook(activeChat.notebookId);
      topic = notebook.topic;
    }
    final profileMap = {
      'age': profile.age,
      'grade': profile.grade,
      'detectedLevel': profile.detectedLevel,
      'locale': profile.locale,
      'learningPreference': profile.learningPreference,
    };
    final contextMap = {
      'courseId': course.id,
      'subject': course.subject,
      'topic': topic,
      'notebookId': notebook.id,
    };
    String? turnId;

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
      turnId = await database.insertGeneratingTurn(
        chatId: chatId,
        question: question,
        profileJson: jsonEncode(profileMap),
        contextJson: jsonEncode(contextMap),
        detail: detail.name,
        engineName: teacher.kind.name,
      );
      final script = await ask(
        question,
        imageJpeg: image,
        age: profile.age,
        grade: profile.grade,
        subject: course.subject,
        topic: topic,
        detectedLevel: profile.detectedLevel,
        locale: profile.locale,
        learningPreference: profile.learningPreference,
        responseDetail: detail,
      );
      const codec = LessonScriptCodec();
      await database.completeTurn(
        turnId: turnId,
        lessonScriptJson: codec.encode(script),
        narrationText: codec.narration(script),
      );
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
      if (turnId != null) await database.failTurn(turnId, e);
      ref.read(attachedImageProvider.notifier).clear();
      state = state.copyWith(
        phase: LessonPhase.error,
        errorMessage: 'No pude armar la lección. Intenta de nuevo.',
        statusMessage: 'Hubo un problema',
      );
    }
  }

  Future<void> replay(ChatTurnRow turn) async {
    final source = turn.lessonScriptJson;
    if (source == null) return;
    final script = const LessonScriptCodec().decode(source);
    final board = ref.read(boardStateProvider.notifier);
    state = state.copyWith(
      phase: LessonPhase.playing,
      lessonTitle: script.title,
      statusMessage: 'Reproduciendo historial',
      clearError: true,
    );
    await ref
        .read(lessonPlayerProvider)
        .play(
          script,
          onBoard: board.replace,
          onStatus: (message) => state = state.copyWith(statusMessage: message),
        );
    state = state.copyWith(
      phase: LessonPhase.idle,
      statusMessage: 'Reproducción terminada',
    );
  }

  Future<void> stop() async {
    await ref.read(lessonPlayerProvider).stop();
    state = state.copyWith(
      phase: LessonPhase.idle,
      statusMessage: 'Detenido. ¿Seguimos?',
    );
  }
}
