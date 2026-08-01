import '../../domain/ports/teacher_ai_port.dart';
import 'lesson_fixtures.dart';

/// Profesor offline con lecciones fixture (demo / degradación).
class StubTeacherAi implements TeacherAiPort {
  @override
  TeacherEngineKind get kind => TeacherEngineKind.stub;

  @override
  Future<bool> isReady() async => true;

  @override
  Future<LessonResult> teach(TeachRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final q = request.question.trim().isEmpty && request.hasImage
        ? 'problema foto'
        : request.question;
    return LessonResult(
      script: LessonFixtures.resolve(q),
      engine: TeacherEngineKind.stub,
      degradedReason: 'Modo demo (Stub)',
    );
  }
}
