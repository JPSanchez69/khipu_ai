import '../lesson_script/lesson_action.dart';

enum TeacherEngineKind { stub, gemma }

/// Puerto de IA profesor — stub o Gemma on-device.
abstract interface class TeacherAiPort {
  TeacherEngineKind get kind;

  Future<bool> isReady();

  /// Genera un LessonScript a partir de la pregunta del estudiante.
  Future<LessonScript> teach(String question);
}
