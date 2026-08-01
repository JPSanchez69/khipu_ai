import 'package:flutter/foundation.dart';
import 'package:flutter_gemma/flutter_gemma.dart';

import '../../domain/lesson_script/lesson_script_parser.dart';
import '../../domain/ports/teacher_ai_port.dart';
import 'gemma_model_config.dart';
import 'lesson_fixtures.dart';
import 'teacher_prompts.dart';

/// Adapter Gemma 3n E2B (LiteRT-LM) vía flutter_gemma.
/// Fallback a fixtures solo con [LessonResult.degradedReason] visible.
class GemmaTeacherAi implements TeacherAiPort {
  GemmaTeacherAi({
    this._parser = const LessonScriptParser(),
  });

  final LessonScriptParser _parser;

  InferenceModel? _model;
  var _ready = false;
  var _vision = false;
  String? _lastInitError;

  @override
  TeacherEngineKind get kind => TeacherEngineKind.gemma;

  @override
  Future<bool> isReady() async {
    await _ensureModel(needVision: false);
    return _ready;
  }

  /// Permite reintentar tras instalar el modelo en caliente.
  void invalidate() {
    _ready = false;
    _vision = false;
    _lastInitError = null;
    _model = null;
  }

  Future<void> _ensureModel({required bool needVision}) async {
    if (_ready && (!needVision || _vision)) return;

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

    final tokens = needVision
        ? GemmaModelConfig.maxTokensWithImage
        : GemmaModelConfig.maxTokens;

    // MVP demo: CPU primero (estable en A54). GPU como respaldo.
    final backends = [PreferredBackend.cpu, PreferredBackend.gpu];

    for (final backend in backends) {
      try {
        _model = await FlutterGemma.getActiveModel(
          maxTokens: tokens,
          preferredBackend: backend,
          // Visión solo si hay foto (carga más liviana en demo texto).
          supportImage: needVision,
          maxNumImages: needVision ? GemmaModelConfig.maxNumImages : 1,
        );
        _ready = true;
        _vision = needVision;
        _lastInitError = null;
        debugPrint('Khipu: Gemma E2B listo ($backend, vision=$needVision)');
        return;
      } catch (e, st) {
        _lastInitError = '$e';
        debugPrint('Khipu: getActiveModel($backend) falló: $e');
        debugPrint('$st');
      }
    }

    _ready = false;
    _vision = false;
    debugPrint('Khipu: Gemma no disponible. Usando fixtures con razón.');
  }

  LessonResult _fixture(TeachRequest request, String reason) {
    return LessonResult(
      script: LessonFixtures.resolve(_fixtureKey(request)),
      engine: TeacherEngineKind.stub,
      degradedReason: reason,
    );
  }

  @override
  Future<LessonResult> teach(TeachRequest request) async {
    final needVision = request.hasImage;
    await _ensureModel(needVision: needVision);
    if (!_ready || _model == null) {
      return _fixture(
        request,
        _lastInitError ?? 'Gemma no listo',
      );
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
        return _fixture(request, 'Respuesta vacía de Gemma');
      }
      try {
        final script = _parser.parseLenient(text);
        return LessonResult(
          script: script,
          engine: TeacherEngineKind.gemma,
        );
      } catch (e) {
        return _fixture(request, 'JSON LessonScript inválido: $e');
      }
    } catch (e) {
      debugPrint('Khipu: inferencia Gemma falló: $e');
      // OOM u otro fallo → permitir reintento en la próxima pregunta.
      _ready = false;
      return _fixture(request, 'Inferencia falló (posible OOM): $e');
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
