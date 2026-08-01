import 'package:flutter/foundation.dart';
import 'package:flutter_gemma/flutter_gemma.dart';

import '../../domain/lesson_script/lesson_action.dart';
import '../../domain/lesson_script/lesson_script_parser.dart';
import '../../domain/lesson_script/lesson_script_quality.dart';
import '../../domain/ports/teacher_ai_port.dart';
import 'gemma_model_config.dart';
import 'teacher_prompts.dart';

/// Adapter Gemma 3 1B-IT (MediaPipe .task) vía flutter_gemma.
/// Texto only: sin visión/fotos. Fallos → [TeacherAiException].
class GemmaTeacherAi implements TeacherAiPort {
  GemmaTeacherAi({
    this._parser = const LessonScriptParser(),
  });

  final LessonScriptParser _parser;

  InferenceModel? _model;
  var _ready = false;
  String? _lastInitError;

  @override
  TeacherEngineKind get kind => TeacherEngineKind.gemma;

  @override
  Future<bool> isReady() async {
    await _ensureModel();
    return _ready;
  }

  /// Permite reintentar tras instalar el modelo en caliente.
  void invalidate() {
    _ready = false;
    _lastInitError = null;
    _model = null;
  }

  Future<void> _ensureModel() async {
    if (_ready) return;

    if (!FlutterGemma.hasActiveModel()) {
      _ready = false;
      _lastInitError = 'Sin modelo activo';
      debugPrint('Khipu: sin modelo activo (auto-install falló o ausente).');
      return;
    }

    try {
      await _model?.close();
    } catch (_) {}
    _model = null;

    // CPU primero (estable en A54). GPU como respaldo.
    final backends = [PreferredBackend.cpu, PreferredBackend.gpu];

    for (final backend in backends) {
      try {
        _model = await FlutterGemma.getActiveModel(
          maxTokens: GemmaModelConfig.maxTokens,
          preferredBackend: backend,
          supportImage: false,
        );
        _ready = true;
        _lastInitError = null;
        debugPrint('Khipu: Gemma 3 1B listo ($backend)');
        return;
      } catch (e, st) {
        _lastInitError = '$e';
        debugPrint('Khipu: getActiveModel($backend) falló: $e');
        debugPrint('$st');
      }
    }

    _ready = false;
    debugPrint('Khipu: Gemma 3 1B no disponible.');
  }

  Never _fail(String message, {Object? cause}) {
    throw TeacherAiException(message, cause: cause);
  }

  /// Parse + calidad jugable (tests / teach).
  LessonScript parsePlayable(String raw) {
    final script = _parser.parseLenient(raw);
    LessonScriptQuality.ensurePlayable(script);
    return script;
  }

  @override
  Future<LessonResult> teach(TeachRequest request) async {
    if (request.hasImage) {
      _fail('Este modelo no admite fotos. Escribe la pregunta en texto.');
    }

    await _ensureModel();
    if (!_ready || _model == null) {
      _fail(
        'Gemma no está listo. Instala gemma3-1b-it-int4.task con push_model.ps1.',
        cause: _lastInitError,
      );
    }

    InferenceChat? chat;
    try {
      chat = await _model!.createChat(
        temperature: 0.3,
        topK: 40,
        topP: 0.9,
        maxOutputTokens: GemmaModelConfig.maxOutputTokens,
        supportImage: false,
        systemInstruction: TeacherPrompts.system,
      );
      if (chat == null) {
        _fail('Gemma no pudo crear la sesión de chat.');
      }

      final first = await _generateOnce(
        chat,
        TeacherPrompts.userQuestion(request.question),
      );
      try {
        final script = parsePlayable(first);
        return LessonResult(
          script: script,
          engine: TeacherEngineKind.gemma,
        );
      } catch (firstError) {
        debugPrint('Khipu: LessonScript inválido, reintento: $firstError');
        final second = await _generateOnce(chat, TeacherPrompts.retryHint);
        try {
          final script = parsePlayable(second);
          return LessonResult(
            script: script,
            engine: TeacherEngineKind.gemma,
          );
        } catch (e) {
          _fail(
            'Gemma no armó una lección para la pizarra. Intenta otra pregunta.',
            cause: e,
          );
        }
      }
    } catch (e) {
      if (e is TeacherAiException) rethrow;
      debugPrint('Khipu: inferencia Gemma falló: $e');
      invalidate();
      _fail(
        'Gemma no pudo generar la lección (posible falta de memoria). '
        'Cierra otras apps e intenta de nuevo.',
        cause: e,
      );
    } finally {
      await chat?.close();
    }
  }

  Future<String> _generateOnce(InferenceChat chat, String userText) async {
    await chat.addQueryChunk(Message.text(text: userText, isUser: true));
    final response = await chat.generateChatResponse();
    final text = switch (response) {
      TextResponse(:final token) => token,
      _ => response.toString(),
    };
    if (text.trim().isEmpty) {
      _fail('Gemma devolvió una lección vacía. Intenta de nuevo.');
    }
    return text;
  }

  Future<void> dispose() async {
    await _model?.close();
  }
}
