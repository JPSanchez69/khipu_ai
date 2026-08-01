import 'package:flutter/foundation.dart';
import 'package:flutter_gemma/flutter_gemma.dart';

import '../../domain/lesson_script/lesson_action.dart';
import '../../domain/lesson_script/lesson_script_parser.dart';
import '../../domain/ports/teacher_ai_port.dart';
import 'gemma_model_config.dart';
import 'lesson_fixtures.dart';
import 'teacher_prompts.dart';

/// Adapter Gemma 3n E2B (LiteRT-LM) vía flutter_gemma.
/// Si el modelo no está instalado o falla (OOM), cae a fixtures.
class GemmaTeacherAi implements TeacherAiPort {
  GemmaTeacherAi({
    this._parser = const LessonScriptParser(),
    this.maxTokens = GemmaModelConfig.maxTokens,
  });

  final LessonScriptParser _parser;
  final int maxTokens;

  InferenceModel? _model;
  var _initAttempted = false;
  var _ready = false;
  var _vision = false;

  @override
  TeacherEngineKind get kind => TeacherEngineKind.gemma;

  @override
  Future<bool> isReady() async {
    await _ensureModel(needVision: false);
    return _ready;
  }

  /// Permite reintentar tras instalar el modelo en caliente.
  void invalidate() {
    _initAttempted = false;
    _ready = false;
    _vision = false;
    _model = null;
  }

  Future<void> _ensureModel({required bool needVision}) async {
    if (_initAttempted && _ready && (!needVision || _vision)) return;
    if (_initAttempted && !_ready) return;

    _initAttempted = true;
    if (!FlutterGemma.hasActiveModel()) {
      _ready = false;
      debugPrint('Khipu: sin modelo activo (instala gemma-3n-E2B-it-litert-lm).');
      return;
    }

    try {
      await _model?.close();
    } catch (_) {}
    _model = null;

    // Multimodal + gama media: GPU primero; CPU si falla (OOM / sin OpenCL).
    for (final backend in [PreferredBackend.gpu, PreferredBackend.cpu]) {
      try {
        _model = await FlutterGemma.getActiveModel(
          maxTokens: maxTokens,
          preferredBackend: backend,
          supportImage: true,
          maxNumImages: GemmaModelConfig.maxNumImages,
        );
        _ready = true;
        _vision = true;
        debugPrint('Khipu: Gemma E2B listo ($backend, vision=true)');
        return;
      } catch (e, st) {
        debugPrint('Khipu: getActiveModel($backend) falló: $e');
        debugPrint('$st');
      }
    }

    _ready = false;
    _vision = false;
    debugPrint('Khipu: Gemma no disponible. Usando fixtures.');
  }

  @override
  Future<LessonScript> teach(TeachRequest request) async {
    final needVision = request.hasImage;
    await _ensureModel(needVision: needVision);
    if (!_ready || _model == null) {
      return LessonFixtures.resolve(_fixtureKey(request));
    }

    InferenceChat? chat;
    try {
      chat = await _model!.createChat(
        temperature: 0.3,
        topK: 40,
        topP: 0.9,
        maxOutputTokens: GemmaModelConfig.maxOutputTokens,
        supportImage: needVision,
        systemInstruction: TeacherPrompts.system,
      );

      final prompt = TeacherPrompts.userQuestion(
        request.question,
        hasImage: needVision,
      );
      final message = needVision
          ? Message.withImage(
              text: prompt,
              imageBytes: request.imageJpeg!,
              isUser: true,
            )
          : Message.text(text: prompt, isUser: true);

      await chat.addQueryChunk(message);
      final response = await chat.generateChatResponse();
      final text = switch (response) {
        TextResponse(:final token) => token,
        _ => response.toString(),
      };
      if (text.trim().isEmpty) {
        return LessonFixtures.resolve(_fixtureKey(request));
      }
      try {
        return _parser.parseLenient(text);
      } catch (_) {
        return LessonFixtures.resolve(_fixtureKey(request));
      }
    } catch (e) {
      debugPrint('Khipu: inferencia Gemma falló: $e');
      // OOM u otro fallo → fixtures, sin crash.
      _ready = false;
      return LessonFixtures.resolve(_fixtureKey(request));
    } finally {
      await chat?.close();
    }
  }

  String _fixtureKey(TeachRequest request) {
    if (request.question.trim().isNotEmpty) return request.question;
    return 'problema foto';
  }

  Future<void> dispose() async {
    await _model?.close();
  }
}
