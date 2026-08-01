import 'package:flutter/foundation.dart';
import 'package:flutter_gemma/flutter_gemma.dart';

import '../../domain/lesson_script/lesson_action.dart';
import '../../domain/lesson_script/lesson_script_parser.dart';
import '../../domain/ports/teacher_ai_port.dart';
import 'lesson_fixtures.dart';
import 'teacher_prompts.dart';

/// Adapter Gemma on-device vía flutter_gemma.
/// Si el modelo no está instalado o falla, cae a fixtures.
class GemmaTeacherAi implements TeacherAiPort {
  GemmaTeacherAi({
    this._parser = const LessonScriptParser(),
    this.maxTokens = 1024,
  });

  final LessonScriptParser _parser;
  final int maxTokens;

  InferenceModel? _model;
  var _initAttempted = false;
  var _ready = false;

  @override
  TeacherEngineKind get kind => TeacherEngineKind.gemma;

  @override
  Future<bool> isReady() async {
    await _ensureModel();
    return _ready;
  }

  Future<void> _ensureModel() async {
    if (_initAttempted) return;
    _initAttempted = true;
    try {
      _model = await FlutterGemma.getActiveModel(maxTokens: maxTokens);
      _ready = true;
      debugPrint('Khipu: Gemma model ready');
    } catch (e, st) {
      _ready = false;
      debugPrint('Khipu: Gemma no disponible ($e). Usando fixtures.');
      debugPrint('$st');
    }
  }

  @override
  Future<LessonScript> teach(String question) async {
    await _ensureModel();
    if (!_ready || _model == null) {
      return LessonFixtures.resolve(question);
    }

    InferenceChat? chat;
    try {
      chat = await _model!.createChat(
        temperature: 0.3,
        topK: 40,
        topP: 0.9,
        maxOutputTokens: maxTokens,
        systemInstruction: TeacherPrompts.system,
      );
      await chat.addQueryChunk(
        Message.text(
          text: TeacherPrompts.userQuestion(question),
          isUser: true,
        ),
      );
      final response = await chat.generateChatResponse();
      final text = switch (response) {
        TextResponse(:final token) => token,
        _ => response.toString(),
      };
      if (text.trim().isEmpty) {
        return LessonFixtures.resolve(question);
      }
      try {
        return _parser.parseLenient(text);
      } catch (_) {
        return LessonFixtures.resolve(question);
      }
    } catch (e) {
      debugPrint('Khipu: inferencia Gemma falló: $e');
      return LessonFixtures.resolve(question);
    } finally {
      await chat?.close();
    }
  }

  Future<void> dispose() async {
    await _model?.close();
  }
}
