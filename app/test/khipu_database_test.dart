import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/infrastructure/database/khipu_database.dart';

void main() {
  test('SQLite persiste perfil, jerarquía y LessonScript JSON', () async {
    final database = KhipuDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    final profile = await database.getProfile();
    expect(profile.age, 12);
    expect(profile.locale, 'es-PE');

    final course = await database.courseForTitle(
      'Matemática · Ecuaciones lineales',
    );
    final notebook = await database.ensureNotebookForCourse(
      course.id,
      title: 'Álgebra del colegio',
      topic: 'Ecuaciones lineales',
    );
    final chat = await database.createChat(notebook.id, 'Resolver 2x + 3');
    final turnId = await database.insertGeneratingTurn(
      chatId: chat.id,
      question: '¿Cómo resuelvo 2x + 3 = 11?',
      profileJson: '{"age":12}',
      contextJson: '{"topic":"Ecuaciones lineales"}',
      detail: 'standard',
      engineName: 'gemma',
    );
    await database.completeTurn(
      turnId: turnId,
      lessonScriptJson:
          '{"schemaVersion":"0.1","title":"Ecuación","actions":[]}',
      narrationText: 'Primero restamos tres.',
    );

    final turns = await database.watchTurns(chat.id).first;
    expect(turns, hasLength(1));
    expect(turns.single.status, 'completed');
    expect(turns.single.lessonScriptJson, contains('schemaVersion'));
  });
}
