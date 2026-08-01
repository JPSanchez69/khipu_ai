import 'dart:typed_data';

import '../lesson_script/lesson_action.dart';

enum TeacherEngineKind { stub, gemma }

enum ResponseDetail { simple, standard, detailed }

/// Entrada al profesor: texto y/o una foto (JPEG ya preparado).
class TeachRequest {
  const TeachRequest({
    required this.question,
    this.imageJpeg,
    this.age = 12,
    this.grade = 'Primero de secundaria',
    this.subject = 'Matemática',
    this.topic = 'Ecuaciones lineales',
    this.detectedLevel = 'basic',
    this.locale = 'es-PE',
    this.learningPreference = 'visual',
    this.responseDetail = ResponseDetail.standard,
  });

  final String question;
  final Uint8List? imageJpeg;
  final int age;
  final String grade;
  final String subject;
  final String topic;
  final String detectedLevel;
  final String locale;
  final String learningPreference;
  final ResponseDetail responseDetail;

  bool get hasImage => imageJpeg != null && imageJpeg!.isNotEmpty;
}

/// Puerto de IA profesor — stub o Gemma on-device.
abstract interface class TeacherAiPort {
  TeacherEngineKind get kind;

  Future<bool> isReady();

  /// Genera un LessonScript a partir de la pregunta (± foto).
  Future<LessonScript> teach(TeachRequest request);
}
