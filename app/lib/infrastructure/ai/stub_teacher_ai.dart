import '../../domain/lesson_script/lesson_action.dart';
import '../../domain/ports/teacher_ai_port.dart';
import 'lesson_fixtures.dart';

/// Profesor offline con lecciones fixture (demo sin modelo).
class StubTeacherAi implements TeacherAiPort {
  @override
  TeacherEngineKind get kind => TeacherEngineKind.stub;

  @override
  Future<bool> isReady() async => true;

  @override
  Future<LessonScript> teach(TeachRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final q = request.question.trim().isEmpty && request.hasImage
        ? 'problema foto'
        : request.question;
    return LessonFixtures.resolve(q);
  }
}
