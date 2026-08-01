import 'dart:typed_data';

import '../domain/lesson_script/lesson_action.dart';
import '../domain/ports/teacher_ai_port.dart';

class AskQuestion {
  AskQuestion(this._teacher);

  final TeacherAiPort _teacher;

  Future<LessonScript> call(
    String question, {
    Uint8List? imageJpeg,
  }) {
    final q = question.trim();
    if (q.isEmpty && (imageJpeg == null || imageJpeg.isEmpty)) {
      throw ArgumentError('Escribe una pregunta o adjunta una foto');
    }
    return _teacher.teach(TeachRequest(question: q, imageJpeg: imageJpeg));
  }
}
