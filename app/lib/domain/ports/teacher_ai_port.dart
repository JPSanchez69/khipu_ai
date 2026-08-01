import 'dart:typed_data';

import '../lesson_script/lesson_action.dart';

enum TeacherEngineKind { stub, gemma }

/// Entrada al profesor: texto y/o una foto (JPEG ya preparado).
class TeachRequest {
  const TeachRequest({
    required this.question,
    this.imageJpeg,
  });

  final String question;
  final Uint8List? imageJpeg;

  bool get hasImage => imageJpeg != null && imageJpeg!.isNotEmpty;
}

/// Resultado de teach: script + motor efectivo (+ razón si degradó).
class LessonResult {
  const LessonResult({
    required this.script,
    required this.engine,
    this.degradedReason,
  });

  final LessonScript script;
  final TeacherEngineKind engine;
  final String? degradedReason;

  bool get isDegraded => degradedReason != null;
}

/// Puerto de IA profesor — stub o Gemma on-device.
abstract interface class TeacherAiPort {
  TeacherEngineKind get kind;

  Future<bool> isReady();

  /// Genera un LessonScript a partir de la pregunta (± foto).
  Future<LessonResult> teach(TeachRequest request);
}
