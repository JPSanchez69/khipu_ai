import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'khipu_database.g.dart';

@DataClassName('StudentProfileRow')
class StudentProfiles extends Table {
  TextColumn get id => text()();
  IntColumn get age => integer()();
  TextColumn get grade => text()();
  TextColumn get detectedLevel => text().withDefault(const Constant('basic'))();
  TextColumn get levelSource => text().withDefault(const Constant('default'))();
  TextColumn get locale => text().withDefault(const Constant('es-PE'))();
  TextColumn get learningPreference =>
      text().withDefault(const Constant('visual'))();
  TextColumn get defaultResponseDetail =>
      text().withDefault(const Constant('standard'))();
  TextColumn get voiceName => text().nullable()();
  TextColumn get voiceLocale => text().withDefault(const Constant('es-PE'))();
  RealColumn get speechRate => real().withDefault(const Constant(0.52))();
  RealColumn get speechPitch => real().withDefault(const Constant(1.0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CourseRow')
class Courses extends Table {
  TextColumn get id => text()();
  TextColumn get subject => text()();
  TextColumn get title => text()();
  TextColumn get grade => text()();
  TextColumn get educationLevel => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('NotebookRow')
class Notebooks extends Table {
  TextColumn get id => text()();
  TextColumn get courseId =>
      text().references(Courses, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  TextColumn get topic => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ChatRow')
class Chats extends Table {
  TextColumn get id => text()();
  TextColumn get notebookId =>
      text().references(Notebooks, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ChatTurnRow')
class ChatTurns extends Table {
  TextColumn get id => text()();
  TextColumn get chatId =>
      text().references(Chats, #id, onDelete: KeyAction.cascade)();
  IntColumn get position => integer()();
  TextColumn get userQuestion => text()();
  TextColumn get lessonScriptJson => text().nullable()();
  TextColumn get narrationText => text().nullable()();
  TextColumn get profileSnapshotJson => text()();
  TextColumn get learningContextJson => text()();
  TextColumn get responseDetail => text()();
  TextColumn get engine => text()();
  TextColumn get status => text().withDefault(const Constant('generating'))();
  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {chatId, position},
  ];
}

@DriftDatabase(tables: [StudentProfiles, Courses, Notebooks, Chats, ChatTurns])
class KhipuDatabase extends _$KhipuDatabase {
  KhipuDatabase()
    : super(
        driftDatabase(
          name: 'khipu_ai',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  KhipuDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seedDefaults();
    },
    beforeOpen: (_) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await _seedDefaults();
    },
  );

  Future<void> _seedDefaults() async {
    final now = DateTime.now().toUtc();
    await into(studentProfiles).insert(
      StudentProfilesCompanion.insert(
        id: 'local-student',
        age: 12,
        grade: 'Primero de secundaria',
        detectedLevel: const Value('basic'),
        levelSource: const Value('default'),
        locale: const Value('es-PE'),
        learningPreference: const Value('visual'),
        defaultResponseDetail: const Value('standard'),
        voiceLocale: const Value('es-PE'),
        speechRate: const Value(0.52),
        speechPitch: const Value(1.0),
        createdAt: now,
        updatedAt: now,
      ),
      mode: InsertMode.insertOrIgnore,
    );

    for (final seed in _courseSeeds) {
      await into(courses).insert(seed, mode: InsertMode.insertOrIgnore);
    }
  }

  Future<StudentProfileRow> getProfile() => (select(
    studentProfiles,
  )..where((t) => t.id.equals('local-student'))).getSingle();

  Stream<StudentProfileRow> watchProfile() => (select(
    studentProfiles,
  )..where((t) => t.id.equals('local-student'))).watchSingle();

  Future<void> saveProfile(StudentProfilesCompanion profile) =>
      into(studentProfiles).insertOnConflictUpdate(profile);

  Future<void> updateProfile({
    required int age,
    required String grade,
    required String detectedLevel,
    required String locale,
    required String learningPreference,
    required String defaultResponseDetail,
  }) => (update(studentProfiles)..where((t) => t.id.equals('local-student')))
      .write(
        StudentProfilesCompanion(
          age: Value(age),
          grade: Value(grade),
          detectedLevel: Value(detectedLevel),
          locale: Value(locale),
          learningPreference: Value(learningPreference),
          defaultResponseDetail: Value(defaultResponseDetail),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );

  Future<void> updateVoice({
    String? name,
    required String locale,
    required double rate,
    required double pitch,
  }) => (update(studentProfiles)..where((t) => t.id.equals('local-student')))
      .write(
        StudentProfilesCompanion(
          voiceName: Value(name),
          voiceLocale: Value(locale),
          speechRate: Value(rate),
          speechPitch: Value(pitch),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );

  Stream<List<CourseRow>> watchCourses() =>
      (select(courses)
            ..where((t) => t.enabled.equals(true))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .watch();

  Stream<List<NotebookRow>> watchNotebooks(String courseId) =>
      (select(notebooks)
            ..where((t) => t.courseId.equals(courseId) & t.archivedAt.isNull())
            ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
          .watch();

  Future<List<NotebookRow>> getNotebooks(String courseId) =>
      (select(notebooks)
            ..where((t) => t.courseId.equals(courseId) & t.archivedAt.isNull())
            ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
          .get();

  Stream<List<ChatRow>> watchChats(String notebookId) =>
      (select(chats)
            ..where((t) => t.notebookId.equals(notebookId))
            ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
          .watch();

  Future<List<ChatRow>> getChats(String notebookId) =>
      (select(chats)
            ..where((t) => t.notebookId.equals(notebookId))
            ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
          .get();

  Future<NotebookRow> getNotebook(String id) =>
      (select(notebooks)..where((t) => t.id.equals(id))).getSingle();

  Future<ChatRow> getChat(String id) =>
      (select(chats)..where((t) => t.id.equals(id))).getSingle();

  Future<void> updateDefaultResponseDetail(String detail) =>
      (update(
        studentProfiles,
      )..where((t) => t.id.equals('local-student'))).write(
        StudentProfilesCompanion(
          defaultResponseDetail: Value(detail),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );

  Stream<List<ChatTurnRow>> watchTurns(String chatId) =>
      (select(chatTurns)
            ..where((t) => t.chatId.equals(chatId))
            ..orderBy([(t) => OrderingTerm.asc(t.position)]))
          .watch();

  Future<NotebookRow> ensureNotebookForCourse(
    String courseId, {
    required String title,
    required String topic,
  }) async {
    final existing =
        await (select(notebooks)
              ..where(
                (t) =>
                    t.courseId.equals(courseId) &
                    t.title.equals(title) &
                    t.archivedAt.isNull(),
              )
              ..limit(1))
            .getSingleOrNull();
    if (existing != null) return existing;
    final now = DateTime.now().toUtc();
    final id = _newId('notebook');
    await into(notebooks).insert(
      NotebooksCompanion.insert(
        id: id,
        courseId: courseId,
        title: title,
        topic: topic,
        createdAt: now,
        updatedAt: now,
      ),
    );
    return (select(notebooks)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<ChatRow> createChat(String notebookId, String title) async {
    final now = DateTime.now().toUtc();
    final id = _newId('chat');
    await into(chats).insert(
      ChatsCompanion.insert(
        id: id,
        notebookId: notebookId,
        title: title,
        createdAt: now,
        updatedAt: now,
      ),
    );
    return (select(chats)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<ChatRow> ensureChat(String notebookId, String title) async {
    final existing =
        await (select(chats)
              ..where((t) => t.notebookId.equals(notebookId))
              ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])
              ..limit(1))
            .getSingleOrNull();
    return existing ?? createChat(notebookId, title);
  }

  Future<int> nextTurnPosition(String chatId) async {
    final countExpression = chatTurns.id.count();
    final query = selectOnly(chatTurns)
      ..addColumns([countExpression])
      ..where(chatTurns.chatId.equals(chatId));
    final row = await query.getSingle();
    return row.read(countExpression) ?? 0;
  }

  Future<String> insertGeneratingTurn({
    required String chatId,
    required String question,
    required String profileJson,
    required String contextJson,
    required String detail,
    required String engineName,
  }) async {
    final id = _newId('turn');
    await into(chatTurns).insert(
      ChatTurnsCompanion.insert(
        id: id,
        chatId: chatId,
        position: await nextTurnPosition(chatId),
        userQuestion: question,
        profileSnapshotJson: profileJson,
        learningContextJson: contextJson,
        responseDetail: detail,
        engine: engineName,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    return id;
  }

  Future<void> completeTurn({
    required String turnId,
    required String lessonScriptJson,
    required String narrationText,
  }) async {
    await (update(chatTurns)..where((t) => t.id.equals(turnId))).write(
      ChatTurnsCompanion(
        lessonScriptJson: Value(lessonScriptJson),
        narrationText: Value(narrationText),
        status: const Value('completed'),
        completedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> failTurn(String turnId, Object error) async {
    await (update(chatTurns)..where((t) => t.id.equals(turnId))).write(
      ChatTurnsCompanion(
        status: const Value('failed'),
        errorMessage: Value(error.toString()),
      ),
    );
  }

  Future<CourseRow> courseForTitle(String? title) async {
    if (title != null) {
      final exact =
          await (select(courses)
                ..where((t) => t.title.equals(title))
                ..limit(1))
              .getSingleOrNull();
      if (exact != null) return exact;
      final suffix = title.contains('·') ? title.split('·').last.trim() : title;
      final partial =
          await (select(courses)
                ..where((t) => t.title.like('%$suffix%'))
                ..limit(1))
              .getSingleOrNull();
      if (partial != null) return partial;
    }
    return (select(courses)
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])
          ..limit(1))
        .getSingle();
  }
}

String _newId(String prefix) {
  final now = DateTime.now().microsecondsSinceEpoch;
  final random = Random().nextInt(0xFFFFFF).toRadixString(16).padLeft(6, '0');
  return '$prefix-$now-$random';
}

final _courseSeeds = <CoursesCompanion>[
  CoursesCompanion.insert(
    id: 'math-fractions-5-primary',
    subject: 'Matemática',
    title: 'Matemática · Fracciones',
    grade: 'Quinto de primaria',
    educationLevel: 'primary',
    sortOrder: const Value(10),
  ),
  CoursesCompanion.insert(
    id: 'math-multiplication-5-primary',
    subject: 'Matemática',
    title: 'Matemática · Multiplicación',
    grade: 'Quinto de primaria',
    educationLevel: 'primary',
    sortOrder: const Value(20),
  ),
  CoursesCompanion.insert(
    id: 'math-linear-equations-1-secondary',
    subject: 'Matemática',
    title: 'Matemática · Ecuaciones lineales',
    grade: 'Primero de secundaria',
    educationLevel: 'secondary',
    sortOrder: const Value(100),
  ),
  CoursesCompanion.insert(
    id: 'math-geometry-2-secondary',
    subject: 'Matemática',
    title: 'Matemática · Geometría',
    grade: 'Segundo de secundaria',
    educationLevel: 'secondary',
    sortOrder: const Value(110),
  ),
  CoursesCompanion.insert(
    id: 'math-algebra-3-secondary',
    subject: 'Matemática',
    title: 'Matemática · Álgebra',
    grade: 'Tercero de secundaria',
    educationLevel: 'secondary',
    sortOrder: const Value(120),
  ),
];
