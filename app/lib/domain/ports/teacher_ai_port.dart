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

/// Error de motor profesor (sin modelo, OOM, JSON inválido, etc.).
/// La UI debe mostrar [message] y no pintar una lección fixture.
class TeacherAiException implements Exception {
  const TeacherAiException(this.message, {this.cause});

  /// Mensaje seguro para mostrar al estudiante.
  final String message;

  /// Detalle técnico opcional (logs).
  final Object? cause;

  @override
  String toString() => 'TeacherAiException: $message';
}

/// Puerto de IA profesor — Gemma on-device en producto; stub solo en tests.
abstract interface class TeacherAiPort {
  TeacherEngineKind get kind;

  Future<bool> isReady();

  /// Genera un LessonScript a partir de la pregunta (± foto).
  /// Lanza [TeacherAiException] si el motor no puede enseñar.
  Future<LessonResult> teach(TeachRequest request);
}
