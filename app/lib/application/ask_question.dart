import '../domain/lesson_script/lesson_action.dart';
import '../domain/ports/teacher_ai_port.dart';

class AskQuestion {
  AskQuestion(this._teacher);

  final TeacherAiPort _teacher;

  Future<LessonScript> call(String question) {
    final q = question.trim();
    if (q.isEmpty) {
      throw ArgumentError('La pregunta no puede estar vacía');
    }
    return _teacher.teach(q);
  }
}
