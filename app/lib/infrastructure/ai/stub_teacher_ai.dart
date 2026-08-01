import '../../domain/lesson_script/lesson_action.dart';
import '../../domain/ports/teacher_ai_port.dart';
import 'lesson_fixtures.dart';

/// Profesor offline con lecciones fixture (demo 4 GB sin modelo).
class StubTeacherAi implements TeacherAiPort {
  @override
  TeacherEngineKind get kind => TeacherEngineKind.stub;

  @override
  Future<bool> isReady() async => true;

  @override
  Future<LessonScript> teach(String question) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return LessonFixtures.resolve(question);
  }
}
