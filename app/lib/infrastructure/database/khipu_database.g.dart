// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khipu_database.dart';

// ignore_for_file: type=lint
class $StudentProfilesTable extends StudentProfiles
    with TableInfo<$StudentProfilesTable, StudentProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
    'grade',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detectedLevelMeta = const VerificationMeta(
    'detectedLevel',
  );
  @override
  late final GeneratedColumn<String> detectedLevel = GeneratedColumn<String>(
    'detected_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('basic'),
  );
  static const VerificationMeta _levelSourceMeta = const VerificationMeta(
    'levelSource',
  );
  @override
  late final GeneratedColumn<String> levelSource = GeneratedColumn<String>(
    'level_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('default'),
  );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('es-PE'),
  );
  static const VerificationMeta _learningPreferenceMeta =
      const VerificationMeta('learningPreference');
  @override
  late final GeneratedColumn<String> learningPreference =
      GeneratedColumn<String>(
        'learning_preference',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('visual'),
      );
  static const VerificationMeta _defaultResponseDetailMeta =
      const VerificationMeta('defaultResponseDetail');
  @override
  late final GeneratedColumn<String> defaultResponseDetail =
      GeneratedColumn<String>(
        'default_response_detail',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('standard'),
      );
  static const VerificationMeta _voiceNameMeta = const VerificationMeta(
    'voiceName',
  );
  @override
  late final GeneratedColumn<String> voiceName = GeneratedColumn<String>(
    'voice_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voiceLocaleMeta = const VerificationMeta(
    'voiceLocale',
  );
  @override
  late final GeneratedColumn<String> voiceLocale = GeneratedColumn<String>(
    'voice_locale',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('es-PE'),
  );
  static const VerificationMeta _speechRateMeta = const VerificationMeta(
    'speechRate',
  );
  @override
  late final GeneratedColumn<double> speechRate = GeneratedColumn<double>(
    'speech_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.52),
  );
  static const VerificationMeta _speechPitchMeta = const VerificationMeta(
    'speechPitch',
  );
  @override
  late final GeneratedColumn<double> speechPitch = GeneratedColumn<double>(
    'speech_pitch',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    age,
    grade,
    detectedLevel,
    levelSource,
    locale,
    learningPreference,
    defaultResponseDetail,
    voiceName,
    voiceLocale,
    speechRate,
    speechPitch,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudentProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('detected_level')) {
      context.handle(
        _detectedLevelMeta,
        detectedLevel.isAcceptableOrUnknown(
          data['detected_level']!,
          _detectedLevelMeta,
        ),
      );
    }
    if (data.containsKey('level_source')) {
      context.handle(
        _levelSourceMeta,
        levelSource.isAcceptableOrUnknown(
          data['level_source']!,
          _levelSourceMeta,
        ),
      );
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    }
    if (data.containsKey('learning_preference')) {
      context.handle(
        _learningPreferenceMeta,
        learningPreference.isAcceptableOrUnknown(
          data['learning_preference']!,
          _learningPreferenceMeta,
        ),
      );
    }
    if (data.containsKey('default_response_detail')) {
      context.handle(
        _defaultResponseDetailMeta,
        defaultResponseDetail.isAcceptableOrUnknown(
          data['default_response_detail']!,
          _defaultResponseDetailMeta,
        ),
      );
    }
    if (data.containsKey('voice_name')) {
      context.handle(
        _voiceNameMeta,
        voiceName.isAcceptableOrUnknown(data['voice_name']!, _voiceNameMeta),
      );
    }
    if (data.containsKey('voice_locale')) {
      context.handle(
        _voiceLocaleMeta,
        voiceLocale.isAcceptableOrUnknown(
          data['voice_locale']!,
          _voiceLocaleMeta,
        ),
      );
    }
    if (data.containsKey('speech_rate')) {
      context.handle(
        _speechRateMeta,
        speechRate.isAcceptableOrUnknown(data['speech_rate']!, _speechRateMeta),
      );
    }
    if (data.containsKey('speech_pitch')) {
      context.handle(
        _speechPitchMeta,
        speechPitch.isAcceptableOrUnknown(
          data['speech_pitch']!,
          _speechPitchMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grade'],
      )!,
      detectedLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detected_level'],
      )!,
      levelSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level_source'],
      )!,
      locale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale'],
      )!,
      learningPreference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}learning_preference'],
      )!,
      defaultResponseDetail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_response_detail'],
      )!,
      voiceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}voice_name'],
      ),
      voiceLocale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}voice_locale'],
      )!,
      speechRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speech_rate'],
      )!,
      speechPitch: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speech_pitch'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StudentProfilesTable createAlias(String alias) {
    return $StudentProfilesTable(attachedDatabase, alias);
  }
}

class StudentProfileRow extends DataClass
    implements Insertable<StudentProfileRow> {
  final String id;
  final int age;
  final String grade;
  final String detectedLevel;
  final String levelSource;
  final String locale;
  final String learningPreference;
  final String defaultResponseDetail;
  final String? voiceName;
  final String voiceLocale;
  final double speechRate;
  final double speechPitch;
  final DateTime createdAt;
  final DateTime updatedAt;
  const StudentProfileRow({
    required this.id,
    required this.age,
    required this.grade,
    required this.detectedLevel,
    required this.levelSource,
    required this.locale,
    required this.learningPreference,
    required this.defaultResponseDetail,
    this.voiceName,
    required this.voiceLocale,
    required this.speechRate,
    required this.speechPitch,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['age'] = Variable<int>(age);
    map['grade'] = Variable<String>(grade);
    map['detected_level'] = Variable<String>(detectedLevel);
    map['level_source'] = Variable<String>(levelSource);
    map['locale'] = Variable<String>(locale);
    map['learning_preference'] = Variable<String>(learningPreference);
    map['default_response_detail'] = Variable<String>(defaultResponseDetail);
    if (!nullToAbsent || voiceName != null) {
      map['voice_name'] = Variable<String>(voiceName);
    }
    map['voice_locale'] = Variable<String>(voiceLocale);
    map['speech_rate'] = Variable<double>(speechRate);
    map['speech_pitch'] = Variable<double>(speechPitch);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StudentProfilesCompanion toCompanion(bool nullToAbsent) {
    return StudentProfilesCompanion(
      id: Value(id),
      age: Value(age),
      grade: Value(grade),
      detectedLevel: Value(detectedLevel),
      levelSource: Value(levelSource),
      locale: Value(locale),
      learningPreference: Value(learningPreference),
      defaultResponseDetail: Value(defaultResponseDetail),
      voiceName: voiceName == null && nullToAbsent
          ? const Value.absent()
          : Value(voiceName),
      voiceLocale: Value(voiceLocale),
      speechRate: Value(speechRate),
      speechPitch: Value(speechPitch),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory StudentProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentProfileRow(
      id: serializer.fromJson<String>(json['id']),
      age: serializer.fromJson<int>(json['age']),
      grade: serializer.fromJson<String>(json['grade']),
      detectedLevel: serializer.fromJson<String>(json['detectedLevel']),
      levelSource: serializer.fromJson<String>(json['levelSource']),
      locale: serializer.fromJson<String>(json['locale']),
      learningPreference: serializer.fromJson<String>(
        json['learningPreference'],
      ),
      defaultResponseDetail: serializer.fromJson<String>(
        json['defaultResponseDetail'],
      ),
      voiceName: serializer.fromJson<String?>(json['voiceName']),
      voiceLocale: serializer.fromJson<String>(json['voiceLocale']),
      speechRate: serializer.fromJson<double>(json['speechRate']),
      speechPitch: serializer.fromJson<double>(json['speechPitch']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'age': serializer.toJson<int>(age),
      'grade': serializer.toJson<String>(grade),
      'detectedLevel': serializer.toJson<String>(detectedLevel),
      'levelSource': serializer.toJson<String>(levelSource),
      'locale': serializer.toJson<String>(locale),
      'learningPreference': serializer.toJson<String>(learningPreference),
      'defaultResponseDetail': serializer.toJson<String>(defaultResponseDetail),
      'voiceName': serializer.toJson<String?>(voiceName),
      'voiceLocale': serializer.toJson<String>(voiceLocale),
      'speechRate': serializer.toJson<double>(speechRate),
      'speechPitch': serializer.toJson<double>(speechPitch),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StudentProfileRow copyWith({
    String? id,
    int? age,
    String? grade,
    String? detectedLevel,
    String? levelSource,
    String? locale,
    String? learningPreference,
    String? defaultResponseDetail,
    Value<String?> voiceName = const Value.absent(),
    String? voiceLocale,
    double? speechRate,
    double? speechPitch,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => StudentProfileRow(
    id: id ?? this.id,
    age: age ?? this.age,
    grade: grade ?? this.grade,
    detectedLevel: detectedLevel ?? this.detectedLevel,
    levelSource: levelSource ?? this.levelSource,
    locale: locale ?? this.locale,
    learningPreference: learningPreference ?? this.learningPreference,
    defaultResponseDetail: defaultResponseDetail ?? this.defaultResponseDetail,
    voiceName: voiceName.present ? voiceName.value : this.voiceName,
    voiceLocale: voiceLocale ?? this.voiceLocale,
    speechRate: speechRate ?? this.speechRate,
    speechPitch: speechPitch ?? this.speechPitch,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StudentProfileRow copyWithCompanion(StudentProfilesCompanion data) {
    return StudentProfileRow(
      id: data.id.present ? data.id.value : this.id,
      age: data.age.present ? data.age.value : this.age,
      grade: data.grade.present ? data.grade.value : this.grade,
      detectedLevel: data.detectedLevel.present
          ? data.detectedLevel.value
          : this.detectedLevel,
      levelSource: data.levelSource.present
          ? data.levelSource.value
          : this.levelSource,
      locale: data.locale.present ? data.locale.value : this.locale,
      learningPreference: data.learningPreference.present
          ? data.learningPreference.value
          : this.learningPreference,
      defaultResponseDetail: data.defaultResponseDetail.present
          ? data.defaultResponseDetail.value
          : this.defaultResponseDetail,
      voiceName: data.voiceName.present ? data.voiceName.value : this.voiceName,
      voiceLocale: data.voiceLocale.present
          ? data.voiceLocale.value
          : this.voiceLocale,
      speechRate: data.speechRate.present
          ? data.speechRate.value
          : this.speechRate,
      speechPitch: data.speechPitch.present
          ? data.speechPitch.value
          : this.speechPitch,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentProfileRow(')
          ..write('id: $id, ')
          ..write('age: $age, ')
          ..write('grade: $grade, ')
          ..write('detectedLevel: $detectedLevel, ')
          ..write('levelSource: $levelSource, ')
          ..write('locale: $locale, ')
          ..write('learningPreference: $learningPreference, ')
          ..write('defaultResponseDetail: $defaultResponseDetail, ')
          ..write('voiceName: $voiceName, ')
          ..write('voiceLocale: $voiceLocale, ')
          ..write('speechRate: $speechRate, ')
          ..write('speechPitch: $speechPitch, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    age,
    grade,
    detectedLevel,
    levelSource,
    locale,
    learningPreference,
    defaultResponseDetail,
    voiceName,
    voiceLocale,
    speechRate,
    speechPitch,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentProfileRow &&
          other.id == this.id &&
          other.age == this.age &&
          other.grade == this.grade &&
          other.detectedLevel == this.detectedLevel &&
          other.levelSource == this.levelSource &&
          other.locale == this.locale &&
          other.learningPreference == this.learningPreference &&
          other.defaultResponseDetail == this.defaultResponseDetail &&
          other.voiceName == this.voiceName &&
          other.voiceLocale == this.voiceLocale &&
          other.speechRate == this.speechRate &&
          other.speechPitch == this.speechPitch &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StudentProfilesCompanion extends UpdateCompanion<StudentProfileRow> {
  final Value<String> id;
  final Value<int> age;
  final Value<String> grade;
  final Value<String> detectedLevel;
  final Value<String> levelSource;
  final Value<String> locale;
  final Value<String> learningPreference;
  final Value<String> defaultResponseDetail;
  final Value<String?> voiceName;
  final Value<String> voiceLocale;
  final Value<double> speechRate;
  final Value<double> speechPitch;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const StudentProfilesCompanion({
    this.id = const Value.absent(),
    this.age = const Value.absent(),
    this.grade = const Value.absent(),
    this.detectedLevel = const Value.absent(),
    this.levelSource = const Value.absent(),
    this.locale = const Value.absent(),
    this.learningPreference = const Value.absent(),
    this.defaultResponseDetail = const Value.absent(),
    this.voiceName = const Value.absent(),
    this.voiceLocale = const Value.absent(),
    this.speechRate = const Value.absent(),
    this.speechPitch = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentProfilesCompanion.insert({
    required String id,
    required int age,
    required String grade,
    this.detectedLevel = const Value.absent(),
    this.levelSource = const Value.absent(),
    this.locale = const Value.absent(),
    this.learningPreference = const Value.absent(),
    this.defaultResponseDetail = const Value.absent(),
    this.voiceName = const Value.absent(),
    this.voiceLocale = const Value.absent(),
    this.speechRate = const Value.absent(),
    this.speechPitch = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       age = Value(age),
       grade = Value(grade),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<StudentProfileRow> custom({
    Expression<String>? id,
    Expression<int>? age,
    Expression<String>? grade,
    Expression<String>? detectedLevel,
    Expression<String>? levelSource,
    Expression<String>? locale,
    Expression<String>? learningPreference,
    Expression<String>? defaultResponseDetail,
    Expression<String>? voiceName,
    Expression<String>? voiceLocale,
    Expression<double>? speechRate,
    Expression<double>? speechPitch,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (age != null) 'age': age,
      if (grade != null) 'grade': grade,
      if (detectedLevel != null) 'detected_level': detectedLevel,
      if (levelSource != null) 'level_source': levelSource,
      if (locale != null) 'locale': locale,
      if (learningPreference != null) 'learning_preference': learningPreference,
      if (defaultResponseDetail != null)
        'default_response_detail': defaultResponseDetail,
      if (voiceName != null) 'voice_name': voiceName,
      if (voiceLocale != null) 'voice_locale': voiceLocale,
      if (speechRate != null) 'speech_rate': speechRate,
      if (speechPitch != null) 'speech_pitch': speechPitch,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentProfilesCompanion copyWith({
    Value<String>? id,
    Value<int>? age,
    Value<String>? grade,
    Value<String>? detectedLevel,
    Value<String>? levelSource,
    Value<String>? locale,
    Value<String>? learningPreference,
    Value<String>? defaultResponseDetail,
    Value<String?>? voiceName,
    Value<String>? voiceLocale,
    Value<double>? speechRate,
    Value<double>? speechPitch,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return StudentProfilesCompanion(
      id: id ?? this.id,
      age: age ?? this.age,
      grade: grade ?? this.grade,
      detectedLevel: detectedLevel ?? this.detectedLevel,
      levelSource: levelSource ?? this.levelSource,
      locale: locale ?? this.locale,
      learningPreference: learningPreference ?? this.learningPreference,
      defaultResponseDetail:
          defaultResponseDetail ?? this.defaultResponseDetail,
      voiceName: voiceName ?? this.voiceName,
      voiceLocale: voiceLocale ?? this.voiceLocale,
      speechRate: speechRate ?? this.speechRate,
      speechPitch: speechPitch ?? this.speechPitch,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (detectedLevel.present) {
      map['detected_level'] = Variable<String>(detectedLevel.value);
    }
    if (levelSource.present) {
      map['level_source'] = Variable<String>(levelSource.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (learningPreference.present) {
      map['learning_preference'] = Variable<String>(learningPreference.value);
    }
    if (defaultResponseDetail.present) {
      map['default_response_detail'] = Variable<String>(
        defaultResponseDetail.value,
      );
    }
    if (voiceName.present) {
      map['voice_name'] = Variable<String>(voiceName.value);
    }
    if (voiceLocale.present) {
      map['voice_locale'] = Variable<String>(voiceLocale.value);
    }
    if (speechRate.present) {
      map['speech_rate'] = Variable<double>(speechRate.value);
    }
    if (speechPitch.present) {
      map['speech_pitch'] = Variable<double>(speechPitch.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentProfilesCompanion(')
          ..write('id: $id, ')
          ..write('age: $age, ')
          ..write('grade: $grade, ')
          ..write('detectedLevel: $detectedLevel, ')
          ..write('levelSource: $levelSource, ')
          ..write('locale: $locale, ')
          ..write('learningPreference: $learningPreference, ')
          ..write('defaultResponseDetail: $defaultResponseDetail, ')
          ..write('voiceName: $voiceName, ')
          ..write('voiceLocale: $voiceLocale, ')
          ..write('speechRate: $speechRate, ')
          ..write('speechPitch: $speechPitch, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoursesTable extends Courses with TableInfo<$CoursesTable, CourseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
    'grade',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _educationLevelMeta = const VerificationMeta(
    'educationLevel',
  );
  @override
  late final GeneratedColumn<String> educationLevel = GeneratedColumn<String>(
    'education_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subject,
    title,
    grade,
    educationLevel,
    sortOrder,
    enabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courses';
  @override
  VerificationContext validateIntegrity(
    Insertable<CourseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('education_level')) {
      context.handle(
        _educationLevelMeta,
        educationLevel.isAcceptableOrUnknown(
          data['education_level']!,
          _educationLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_educationLevelMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CourseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CourseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grade'],
      )!,
      educationLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}education_level'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $CoursesTable createAlias(String alias) {
    return $CoursesTable(attachedDatabase, alias);
  }
}

class CourseRow extends DataClass implements Insertable<CourseRow> {
  final String id;
  final String subject;
  final String title;
  final String grade;
  final String educationLevel;
  final int sortOrder;
  final bool enabled;
  const CourseRow({
    required this.id,
    required this.subject,
    required this.title,
    required this.grade,
    required this.educationLevel,
    required this.sortOrder,
    required this.enabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['subject'] = Variable<String>(subject);
    map['title'] = Variable<String>(title);
    map['grade'] = Variable<String>(grade);
    map['education_level'] = Variable<String>(educationLevel);
    map['sort_order'] = Variable<int>(sortOrder);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  CoursesCompanion toCompanion(bool nullToAbsent) {
    return CoursesCompanion(
      id: Value(id),
      subject: Value(subject),
      title: Value(title),
      grade: Value(grade),
      educationLevel: Value(educationLevel),
      sortOrder: Value(sortOrder),
      enabled: Value(enabled),
    );
  }

  factory CourseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseRow(
      id: serializer.fromJson<String>(json['id']),
      subject: serializer.fromJson<String>(json['subject']),
      title: serializer.fromJson<String>(json['title']),
      grade: serializer.fromJson<String>(json['grade']),
      educationLevel: serializer.fromJson<String>(json['educationLevel']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'subject': serializer.toJson<String>(subject),
      'title': serializer.toJson<String>(title),
      'grade': serializer.toJson<String>(grade),
      'educationLevel': serializer.toJson<String>(educationLevel),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  CourseRow copyWith({
    String? id,
    String? subject,
    String? title,
    String? grade,
    String? educationLevel,
    int? sortOrder,
    bool? enabled,
  }) => CourseRow(
    id: id ?? this.id,
    subject: subject ?? this.subject,
    title: title ?? this.title,
    grade: grade ?? this.grade,
    educationLevel: educationLevel ?? this.educationLevel,
    sortOrder: sortOrder ?? this.sortOrder,
    enabled: enabled ?? this.enabled,
  );
  CourseRow copyWithCompanion(CoursesCompanion data) {
    return CourseRow(
      id: data.id.present ? data.id.value : this.id,
      subject: data.subject.present ? data.subject.value : this.subject,
      title: data.title.present ? data.title.value : this.title,
      grade: data.grade.present ? data.grade.value : this.grade,
      educationLevel: data.educationLevel.present
          ? data.educationLevel.value
          : this.educationLevel,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CourseRow(')
          ..write('id: $id, ')
          ..write('subject: $subject, ')
          ..write('title: $title, ')
          ..write('grade: $grade, ')
          ..write('educationLevel: $educationLevel, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subject,
    title,
    grade,
    educationLevel,
    sortOrder,
    enabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseRow &&
          other.id == this.id &&
          other.subject == this.subject &&
          other.title == this.title &&
          other.grade == this.grade &&
          other.educationLevel == this.educationLevel &&
          other.sortOrder == this.sortOrder &&
          other.enabled == this.enabled);
}

class CoursesCompanion extends UpdateCompanion<CourseRow> {
  final Value<String> id;
  final Value<String> subject;
  final Value<String> title;
  final Value<String> grade;
  final Value<String> educationLevel;
  final Value<int> sortOrder;
  final Value<bool> enabled;
  final Value<int> rowid;
  const CoursesCompanion({
    this.id = const Value.absent(),
    this.subject = const Value.absent(),
    this.title = const Value.absent(),
    this.grade = const Value.absent(),
    this.educationLevel = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoursesCompanion.insert({
    required String id,
    required String subject,
    required String title,
    required String grade,
    required String educationLevel,
    this.sortOrder = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       subject = Value(subject),
       title = Value(title),
       grade = Value(grade),
       educationLevel = Value(educationLevel);
  static Insertable<CourseRow> custom({
    Expression<String>? id,
    Expression<String>? subject,
    Expression<String>? title,
    Expression<String>? grade,
    Expression<String>? educationLevel,
    Expression<int>? sortOrder,
    Expression<bool>? enabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subject != null) 'subject': subject,
      if (title != null) 'title': title,
      if (grade != null) 'grade': grade,
      if (educationLevel != null) 'education_level': educationLevel,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (enabled != null) 'enabled': enabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoursesCompanion copyWith({
    Value<String>? id,
    Value<String>? subject,
    Value<String>? title,
    Value<String>? grade,
    Value<String>? educationLevel,
    Value<int>? sortOrder,
    Value<bool>? enabled,
    Value<int>? rowid,
  }) {
    return CoursesCompanion(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      title: title ?? this.title,
      grade: grade ?? this.grade,
      educationLevel: educationLevel ?? this.educationLevel,
      sortOrder: sortOrder ?? this.sortOrder,
      enabled: enabled ?? this.enabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (educationLevel.present) {
      map['education_level'] = Variable<String>(educationLevel.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCompanion(')
          ..write('id: $id, ')
          ..write('subject: $subject, ')
          ..write('title: $title, ')
          ..write('grade: $grade, ')
          ..write('educationLevel: $educationLevel, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('enabled: $enabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotebooksTable extends Notebooks
    with TableInfo<$NotebooksTable, NotebookRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotebooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseIdMeta = const VerificationMeta(
    'courseId',
  );
  @override
  late final GeneratedColumn<String> courseId = GeneratedColumn<String>(
    'course_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES courses (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _topicMeta = const VerificationMeta('topic');
  @override
  late final GeneratedColumn<String> topic = GeneratedColumn<String>(
    'topic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    courseId,
    title,
    topic,
    description,
    createdAt,
    updatedAt,
    archivedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notebooks';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotebookRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('course_id')) {
      context.handle(
        _courseIdMeta,
        courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('topic')) {
      context.handle(
        _topicMeta,
        topic.isAcceptableOrUnknown(data['topic']!, _topicMeta),
      );
    } else if (isInserting) {
      context.missing(_topicMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotebookRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotebookRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      courseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      topic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
    );
  }

  @override
  $NotebooksTable createAlias(String alias) {
    return $NotebooksTable(attachedDatabase, alias);
  }
}

class NotebookRow extends DataClass implements Insertable<NotebookRow> {
  final String id;
  final String courseId;
  final String title;
  final String topic;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;
  const NotebookRow({
    required this.id,
    required this.courseId,
    required this.title,
    required this.topic,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.archivedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['course_id'] = Variable<String>(courseId);
    map['title'] = Variable<String>(title);
    map['topic'] = Variable<String>(topic);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    return map;
  }

  NotebooksCompanion toCompanion(bool nullToAbsent) {
    return NotebooksCompanion(
      id: Value(id),
      courseId: Value(courseId),
      title: Value(title),
      topic: Value(topic),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
    );
  }

  factory NotebookRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotebookRow(
      id: serializer.fromJson<String>(json['id']),
      courseId: serializer.fromJson<String>(json['courseId']),
      title: serializer.fromJson<String>(json['title']),
      topic: serializer.fromJson<String>(json['topic']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'courseId': serializer.toJson<String>(courseId),
      'title': serializer.toJson<String>(title),
      'topic': serializer.toJson<String>(topic),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
    };
  }

  NotebookRow copyWith({
    String? id,
    String? courseId,
    String? title,
    String? topic,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> archivedAt = const Value.absent(),
  }) => NotebookRow(
    id: id ?? this.id,
    courseId: courseId ?? this.courseId,
    title: title ?? this.title,
    topic: topic ?? this.topic,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
  );
  NotebookRow copyWithCompanion(NotebooksCompanion data) {
    return NotebookRow(
      id: data.id.present ? data.id.value : this.id,
      courseId: data.courseId.present ? data.courseId.value : this.courseId,
      title: data.title.present ? data.title.value : this.title,
      topic: data.topic.present ? data.topic.value : this.topic,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotebookRow(')
          ..write('id: $id, ')
          ..write('courseId: $courseId, ')
          ..write('title: $title, ')
          ..write('topic: $topic, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    courseId,
    title,
    topic,
    description,
    createdAt,
    updatedAt,
    archivedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotebookRow &&
          other.id == this.id &&
          other.courseId == this.courseId &&
          other.title == this.title &&
          other.topic == this.topic &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.archivedAt == this.archivedAt);
}

class NotebooksCompanion extends UpdateCompanion<NotebookRow> {
  final Value<String> id;
  final Value<String> courseId;
  final Value<String> title;
  final Value<String> topic;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> archivedAt;
  final Value<int> rowid;
  const NotebooksCompanion({
    this.id = const Value.absent(),
    this.courseId = const Value.absent(),
    this.title = const Value.absent(),
    this.topic = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotebooksCompanion.insert({
    required String id,
    required String courseId,
    required String title,
    required String topic,
    this.description = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       courseId = Value(courseId),
       title = Value(title),
       topic = Value(topic),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<NotebookRow> custom({
    Expression<String>? id,
    Expression<String>? courseId,
    Expression<String>? title,
    Expression<String>? topic,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? archivedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (courseId != null) 'course_id': courseId,
      if (title != null) 'title': title,
      if (topic != null) 'topic': topic,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotebooksCompanion copyWith({
    Value<String>? id,
    Value<String>? courseId,
    Value<String>? title,
    Value<String>? topic,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? archivedAt,
    Value<int>? rowid,
  }) {
    return NotebooksCompanion(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      topic: topic ?? this.topic,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      archivedAt: archivedAt ?? this.archivedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (courseId.present) {
      map['course_id'] = Variable<String>(courseId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (topic.present) {
      map['topic'] = Variable<String>(topic.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotebooksCompanion(')
          ..write('id: $id, ')
          ..write('courseId: $courseId, ')
          ..write('title: $title, ')
          ..write('topic: $topic, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatsTable extends Chats with TableInfo<$ChatsTable, ChatRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notebookIdMeta = const VerificationMeta(
    'notebookId',
  );
  @override
  late final GeneratedColumn<String> notebookId = GeneratedColumn<String>(
    'notebook_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES notebooks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    notebookId,
    title,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chats';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('notebook_id')) {
      context.handle(
        _notebookIdMeta,
        notebookId.isAcceptableOrUnknown(data['notebook_id']!, _notebookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_notebookIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      notebookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notebook_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ChatsTable createAlias(String alias) {
    return $ChatsTable(attachedDatabase, alias);
  }
}

class ChatRow extends DataClass implements Insertable<ChatRow> {
  final String id;
  final String notebookId;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ChatRow({
    required this.id,
    required this.notebookId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['notebook_id'] = Variable<String>(notebookId);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChatsCompanion toCompanion(bool nullToAbsent) {
    return ChatsCompanion(
      id: Value(id),
      notebookId: Value(notebookId),
      title: Value(title),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ChatRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatRow(
      id: serializer.fromJson<String>(json['id']),
      notebookId: serializer.fromJson<String>(json['notebookId']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'notebookId': serializer.toJson<String>(notebookId),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ChatRow copyWith({
    String? id,
    String? notebookId,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ChatRow(
    id: id ?? this.id,
    notebookId: notebookId ?? this.notebookId,
    title: title ?? this.title,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ChatRow copyWithCompanion(ChatsCompanion data) {
    return ChatRow(
      id: data.id.present ? data.id.value : this.id,
      notebookId: data.notebookId.present
          ? data.notebookId.value
          : this.notebookId,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatRow(')
          ..write('id: $id, ')
          ..write('notebookId: $notebookId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, notebookId, title, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatRow &&
          other.id == this.id &&
          other.notebookId == this.notebookId &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ChatsCompanion extends UpdateCompanion<ChatRow> {
  final Value<String> id;
  final Value<String> notebookId;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ChatsCompanion({
    this.id = const Value.absent(),
    this.notebookId = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatsCompanion.insert({
    required String id,
    required String notebookId,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       notebookId = Value(notebookId),
       title = Value(title),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ChatRow> custom({
    Expression<String>? id,
    Expression<String>? notebookId,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (notebookId != null) 'notebook_id': notebookId,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatsCompanion copyWith({
    Value<String>? id,
    Value<String>? notebookId,
    Value<String>? title,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ChatsCompanion(
      id: id ?? this.id,
      notebookId: notebookId ?? this.notebookId,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (notebookId.present) {
      map['notebook_id'] = Variable<String>(notebookId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatsCompanion(')
          ..write('id: $id, ')
          ..write('notebookId: $notebookId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatTurnsTable extends ChatTurns
    with TableInfo<$ChatTurnsTable, ChatTurnRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatTurnsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<String> chatId = GeneratedColumn<String>(
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chats (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userQuestionMeta = const VerificationMeta(
    'userQuestion',
  );
  @override
  late final GeneratedColumn<String> userQuestion = GeneratedColumn<String>(
    'user_question',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lessonScriptJsonMeta = const VerificationMeta(
    'lessonScriptJson',
  );
  @override
  late final GeneratedColumn<String> lessonScriptJson = GeneratedColumn<String>(
    'lesson_script_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _narrationTextMeta = const VerificationMeta(
    'narrationText',
  );
  @override
  late final GeneratedColumn<String> narrationText = GeneratedColumn<String>(
    'narration_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profileSnapshotJsonMeta =
      const VerificationMeta('profileSnapshotJson');
  @override
  late final GeneratedColumn<String> profileSnapshotJson =
      GeneratedColumn<String>(
        'profile_snapshot_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _learningContextJsonMeta =
      const VerificationMeta('learningContextJson');
  @override
  late final GeneratedColumn<String> learningContextJson =
      GeneratedColumn<String>(
        'learning_context_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _responseDetailMeta = const VerificationMeta(
    'responseDetail',
  );
  @override
  late final GeneratedColumn<String> responseDetail = GeneratedColumn<String>(
    'response_detail',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _engineMeta = const VerificationMeta('engine');
  @override
  late final GeneratedColumn<String> engine = GeneratedColumn<String>(
    'engine',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('generating'),
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    chatId,
    position,
    userQuestion,
    lessonScriptJson,
    narrationText,
    profileSnapshotJson,
    learningContextJson,
    responseDetail,
    engine,
    status,
    errorMessage,
    createdAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_turns';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatTurnRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('user_question')) {
      context.handle(
        _userQuestionMeta,
        userQuestion.isAcceptableOrUnknown(
          data['user_question']!,
          _userQuestionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userQuestionMeta);
    }
    if (data.containsKey('lesson_script_json')) {
      context.handle(
        _lessonScriptJsonMeta,
        lessonScriptJson.isAcceptableOrUnknown(
          data['lesson_script_json']!,
          _lessonScriptJsonMeta,
        ),
      );
    }
    if (data.containsKey('narration_text')) {
      context.handle(
        _narrationTextMeta,
        narrationText.isAcceptableOrUnknown(
          data['narration_text']!,
          _narrationTextMeta,
        ),
      );
    }
    if (data.containsKey('profile_snapshot_json')) {
      context.handle(
        _profileSnapshotJsonMeta,
        profileSnapshotJson.isAcceptableOrUnknown(
          data['profile_snapshot_json']!,
          _profileSnapshotJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_profileSnapshotJsonMeta);
    }
    if (data.containsKey('learning_context_json')) {
      context.handle(
        _learningContextJsonMeta,
        learningContextJson.isAcceptableOrUnknown(
          data['learning_context_json']!,
          _learningContextJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_learningContextJsonMeta);
    }
    if (data.containsKey('response_detail')) {
      context.handle(
        _responseDetailMeta,
        responseDetail.isAcceptableOrUnknown(
          data['response_detail']!,
          _responseDetailMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_responseDetailMeta);
    }
    if (data.containsKey('engine')) {
      context.handle(
        _engineMeta,
        engine.isAcceptableOrUnknown(data['engine']!, _engineMeta),
      );
    } else if (isInserting) {
      context.missing(_engineMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {chatId, position},
  ];
  @override
  ChatTurnRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatTurnRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chat_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      userQuestion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_question'],
      )!,
      lessonScriptJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lesson_script_json'],
      ),
      narrationText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}narration_text'],
      ),
      profileSnapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_snapshot_json'],
      )!,
      learningContextJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}learning_context_json'],
      )!,
      responseDetail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}response_detail'],
      )!,
      engine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}engine'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $ChatTurnsTable createAlias(String alias) {
    return $ChatTurnsTable(attachedDatabase, alias);
  }
}

class ChatTurnRow extends DataClass implements Insertable<ChatTurnRow> {
  final String id;
  final String chatId;
  final int position;
  final String userQuestion;
  final String? lessonScriptJson;
  final String? narrationText;
  final String profileSnapshotJson;
  final String learningContextJson;
  final String responseDetail;
  final String engine;
  final String status;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime? completedAt;
  const ChatTurnRow({
    required this.id,
    required this.chatId,
    required this.position,
    required this.userQuestion,
    this.lessonScriptJson,
    this.narrationText,
    required this.profileSnapshotJson,
    required this.learningContextJson,
    required this.responseDetail,
    required this.engine,
    required this.status,
    this.errorMessage,
    required this.createdAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['chat_id'] = Variable<String>(chatId);
    map['position'] = Variable<int>(position);
    map['user_question'] = Variable<String>(userQuestion);
    if (!nullToAbsent || lessonScriptJson != null) {
      map['lesson_script_json'] = Variable<String>(lessonScriptJson);
    }
    if (!nullToAbsent || narrationText != null) {
      map['narration_text'] = Variable<String>(narrationText);
    }
    map['profile_snapshot_json'] = Variable<String>(profileSnapshotJson);
    map['learning_context_json'] = Variable<String>(learningContextJson);
    map['response_detail'] = Variable<String>(responseDetail);
    map['engine'] = Variable<String>(engine);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  ChatTurnsCompanion toCompanion(bool nullToAbsent) {
    return ChatTurnsCompanion(
      id: Value(id),
      chatId: Value(chatId),
      position: Value(position),
      userQuestion: Value(userQuestion),
      lessonScriptJson: lessonScriptJson == null && nullToAbsent
          ? const Value.absent()
          : Value(lessonScriptJson),
      narrationText: narrationText == null && nullToAbsent
          ? const Value.absent()
          : Value(narrationText),
      profileSnapshotJson: Value(profileSnapshotJson),
      learningContextJson: Value(learningContextJson),
      responseDetail: Value(responseDetail),
      engine: Value(engine),
      status: Value(status),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory ChatTurnRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatTurnRow(
      id: serializer.fromJson<String>(json['id']),
      chatId: serializer.fromJson<String>(json['chatId']),
      position: serializer.fromJson<int>(json['position']),
      userQuestion: serializer.fromJson<String>(json['userQuestion']),
      lessonScriptJson: serializer.fromJson<String?>(json['lessonScriptJson']),
      narrationText: serializer.fromJson<String?>(json['narrationText']),
      profileSnapshotJson: serializer.fromJson<String>(
        json['profileSnapshotJson'],
      ),
      learningContextJson: serializer.fromJson<String>(
        json['learningContextJson'],
      ),
      responseDetail: serializer.fromJson<String>(json['responseDetail']),
      engine: serializer.fromJson<String>(json['engine']),
      status: serializer.fromJson<String>(json['status']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'chatId': serializer.toJson<String>(chatId),
      'position': serializer.toJson<int>(position),
      'userQuestion': serializer.toJson<String>(userQuestion),
      'lessonScriptJson': serializer.toJson<String?>(lessonScriptJson),
      'narrationText': serializer.toJson<String?>(narrationText),
      'profileSnapshotJson': serializer.toJson<String>(profileSnapshotJson),
      'learningContextJson': serializer.toJson<String>(learningContextJson),
      'responseDetail': serializer.toJson<String>(responseDetail),
      'engine': serializer.toJson<String>(engine),
      'status': serializer.toJson<String>(status),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  ChatTurnRow copyWith({
    String? id,
    String? chatId,
    int? position,
    String? userQuestion,
    Value<String?> lessonScriptJson = const Value.absent(),
    Value<String?> narrationText = const Value.absent(),
    String? profileSnapshotJson,
    String? learningContextJson,
    String? responseDetail,
    String? engine,
    String? status,
    Value<String?> errorMessage = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => ChatTurnRow(
    id: id ?? this.id,
    chatId: chatId ?? this.chatId,
    position: position ?? this.position,
    userQuestion: userQuestion ?? this.userQuestion,
    lessonScriptJson: lessonScriptJson.present
        ? lessonScriptJson.value
        : this.lessonScriptJson,
    narrationText: narrationText.present
        ? narrationText.value
        : this.narrationText,
    profileSnapshotJson: profileSnapshotJson ?? this.profileSnapshotJson,
    learningContextJson: learningContextJson ?? this.learningContextJson,
    responseDetail: responseDetail ?? this.responseDetail,
    engine: engine ?? this.engine,
    status: status ?? this.status,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    createdAt: createdAt ?? this.createdAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  ChatTurnRow copyWithCompanion(ChatTurnsCompanion data) {
    return ChatTurnRow(
      id: data.id.present ? data.id.value : this.id,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      position: data.position.present ? data.position.value : this.position,
      userQuestion: data.userQuestion.present
          ? data.userQuestion.value
          : this.userQuestion,
      lessonScriptJson: data.lessonScriptJson.present
          ? data.lessonScriptJson.value
          : this.lessonScriptJson,
      narrationText: data.narrationText.present
          ? data.narrationText.value
          : this.narrationText,
      profileSnapshotJson: data.profileSnapshotJson.present
          ? data.profileSnapshotJson.value
          : this.profileSnapshotJson,
      learningContextJson: data.learningContextJson.present
          ? data.learningContextJson.value
          : this.learningContextJson,
      responseDetail: data.responseDetail.present
          ? data.responseDetail.value
          : this.responseDetail,
      engine: data.engine.present ? data.engine.value : this.engine,
      status: data.status.present ? data.status.value : this.status,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatTurnRow(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('position: $position, ')
          ..write('userQuestion: $userQuestion, ')
          ..write('lessonScriptJson: $lessonScriptJson, ')
          ..write('narrationText: $narrationText, ')
          ..write('profileSnapshotJson: $profileSnapshotJson, ')
          ..write('learningContextJson: $learningContextJson, ')
          ..write('responseDetail: $responseDetail, ')
          ..write('engine: $engine, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    chatId,
    position,
    userQuestion,
    lessonScriptJson,
    narrationText,
    profileSnapshotJson,
    learningContextJson,
    responseDetail,
    engine,
    status,
    errorMessage,
    createdAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatTurnRow &&
          other.id == this.id &&
          other.chatId == this.chatId &&
          other.position == this.position &&
          other.userQuestion == this.userQuestion &&
          other.lessonScriptJson == this.lessonScriptJson &&
          other.narrationText == this.narrationText &&
          other.profileSnapshotJson == this.profileSnapshotJson &&
          other.learningContextJson == this.learningContextJson &&
          other.responseDetail == this.responseDetail &&
          other.engine == this.engine &&
          other.status == this.status &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt);
}

class ChatTurnsCompanion extends UpdateCompanion<ChatTurnRow> {
  final Value<String> id;
  final Value<String> chatId;
  final Value<int> position;
  final Value<String> userQuestion;
  final Value<String?> lessonScriptJson;
  final Value<String?> narrationText;
  final Value<String> profileSnapshotJson;
  final Value<String> learningContextJson;
  final Value<String> responseDetail;
  final Value<String> engine;
  final Value<String> status;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const ChatTurnsCompanion({
    this.id = const Value.absent(),
    this.chatId = const Value.absent(),
    this.position = const Value.absent(),
    this.userQuestion = const Value.absent(),
    this.lessonScriptJson = const Value.absent(),
    this.narrationText = const Value.absent(),
    this.profileSnapshotJson = const Value.absent(),
    this.learningContextJson = const Value.absent(),
    this.responseDetail = const Value.absent(),
    this.engine = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatTurnsCompanion.insert({
    required String id,
    required String chatId,
    required int position,
    required String userQuestion,
    this.lessonScriptJson = const Value.absent(),
    this.narrationText = const Value.absent(),
    required String profileSnapshotJson,
    required String learningContextJson,
    required String responseDetail,
    required String engine,
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    required DateTime createdAt,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       chatId = Value(chatId),
       position = Value(position),
       userQuestion = Value(userQuestion),
       profileSnapshotJson = Value(profileSnapshotJson),
       learningContextJson = Value(learningContextJson),
       responseDetail = Value(responseDetail),
       engine = Value(engine),
       createdAt = Value(createdAt);
  static Insertable<ChatTurnRow> custom({
    Expression<String>? id,
    Expression<String>? chatId,
    Expression<int>? position,
    Expression<String>? userQuestion,
    Expression<String>? lessonScriptJson,
    Expression<String>? narrationText,
    Expression<String>? profileSnapshotJson,
    Expression<String>? learningContextJson,
    Expression<String>? responseDetail,
    Expression<String>? engine,
    Expression<String>? status,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chatId != null) 'chat_id': chatId,
      if (position != null) 'position': position,
      if (userQuestion != null) 'user_question': userQuestion,
      if (lessonScriptJson != null) 'lesson_script_json': lessonScriptJson,
      if (narrationText != null) 'narration_text': narrationText,
      if (profileSnapshotJson != null)
        'profile_snapshot_json': profileSnapshotJson,
      if (learningContextJson != null)
        'learning_context_json': learningContextJson,
      if (responseDetail != null) 'response_detail': responseDetail,
      if (engine != null) 'engine': engine,
      if (status != null) 'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatTurnsCompanion copyWith({
    Value<String>? id,
    Value<String>? chatId,
    Value<int>? position,
    Value<String>? userQuestion,
    Value<String?>? lessonScriptJson,
    Value<String?>? narrationText,
    Value<String>? profileSnapshotJson,
    Value<String>? learningContextJson,
    Value<String>? responseDetail,
    Value<String>? engine,
    Value<String>? status,
    Value<String?>? errorMessage,
    Value<DateTime>? createdAt,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return ChatTurnsCompanion(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      position: position ?? this.position,
      userQuestion: userQuestion ?? this.userQuestion,
      lessonScriptJson: lessonScriptJson ?? this.lessonScriptJson,
      narrationText: narrationText ?? this.narrationText,
      profileSnapshotJson: profileSnapshotJson ?? this.profileSnapshotJson,
      learningContextJson: learningContextJson ?? this.learningContextJson,
      responseDetail: responseDetail ?? this.responseDetail,
      engine: engine ?? this.engine,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<String>(chatId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (userQuestion.present) {
      map['user_question'] = Variable<String>(userQuestion.value);
    }
    if (lessonScriptJson.present) {
      map['lesson_script_json'] = Variable<String>(lessonScriptJson.value);
    }
    if (narrationText.present) {
      map['narration_text'] = Variable<String>(narrationText.value);
    }
    if (profileSnapshotJson.present) {
      map['profile_snapshot_json'] = Variable<String>(
        profileSnapshotJson.value,
      );
    }
    if (learningContextJson.present) {
      map['learning_context_json'] = Variable<String>(
        learningContextJson.value,
      );
    }
    if (responseDetail.present) {
      map['response_detail'] = Variable<String>(responseDetail.value);
    }
    if (engine.present) {
      map['engine'] = Variable<String>(engine.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatTurnsCompanion(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('position: $position, ')
          ..write('userQuestion: $userQuestion, ')
          ..write('lessonScriptJson: $lessonScriptJson, ')
          ..write('narrationText: $narrationText, ')
          ..write('profileSnapshotJson: $profileSnapshotJson, ')
          ..write('learningContextJson: $learningContextJson, ')
          ..write('responseDetail: $responseDetail, ')
          ..write('engine: $engine, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$KhipuDatabase extends GeneratedDatabase {
  _$KhipuDatabase(QueryExecutor e) : super(e);
  $KhipuDatabaseManager get managers => $KhipuDatabaseManager(this);
  late final $StudentProfilesTable studentProfiles = $StudentProfilesTable(
    this,
  );
  late final $CoursesTable courses = $CoursesTable(this);
  late final $NotebooksTable notebooks = $NotebooksTable(this);
  late final $ChatsTable chats = $ChatsTable(this);
  late final $ChatTurnsTable chatTurns = $ChatTurnsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    studentProfiles,
    courses,
    notebooks,
    chats,
    chatTurns,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'courses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('notebooks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'notebooks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('chats', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'chats',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('chat_turns', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$StudentProfilesTableCreateCompanionBuilder =
    StudentProfilesCompanion Function({
      required String id,
      required int age,
      required String grade,
      Value<String> detectedLevel,
      Value<String> levelSource,
      Value<String> locale,
      Value<String> learningPreference,
      Value<String> defaultResponseDetail,
      Value<String?> voiceName,
      Value<String> voiceLocale,
      Value<double> speechRate,
      Value<double> speechPitch,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$StudentProfilesTableUpdateCompanionBuilder =
    StudentProfilesCompanion Function({
      Value<String> id,
      Value<int> age,
      Value<String> grade,
      Value<String> detectedLevel,
      Value<String> levelSource,
      Value<String> locale,
      Value<String> learningPreference,
      Value<String> defaultResponseDetail,
      Value<String?> voiceName,
      Value<String> voiceLocale,
      Value<double> speechRate,
      Value<double> speechPitch,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$StudentProfilesTableFilterComposer
    extends Composer<_$KhipuDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detectedLevel => $composableBuilder(
    column: $table.detectedLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get levelSource => $composableBuilder(
    column: $table.levelSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get learningPreference => $composableBuilder(
    column: $table.learningPreference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultResponseDetail => $composableBuilder(
    column: $table.defaultResponseDetail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get voiceName => $composableBuilder(
    column: $table.voiceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get voiceLocale => $composableBuilder(
    column: $table.voiceLocale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speechRate => $composableBuilder(
    column: $table.speechRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speechPitch => $composableBuilder(
    column: $table.speechPitch,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudentProfilesTableOrderingComposer
    extends Composer<_$KhipuDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detectedLevel => $composableBuilder(
    column: $table.detectedLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get levelSource => $composableBuilder(
    column: $table.levelSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get learningPreference => $composableBuilder(
    column: $table.learningPreference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultResponseDetail => $composableBuilder(
    column: $table.defaultResponseDetail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get voiceName => $composableBuilder(
    column: $table.voiceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get voiceLocale => $composableBuilder(
    column: $table.voiceLocale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speechRate => $composableBuilder(
    column: $table.speechRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speechPitch => $composableBuilder(
    column: $table.speechPitch,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudentProfilesTableAnnotationComposer
    extends Composer<_$KhipuDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get detectedLevel => $composableBuilder(
    column: $table.detectedLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get levelSource => $composableBuilder(
    column: $table.levelSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<String> get learningPreference => $composableBuilder(
    column: $table.learningPreference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultResponseDetail => $composableBuilder(
    column: $table.defaultResponseDetail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get voiceName =>
      $composableBuilder(column: $table.voiceName, builder: (column) => column);

  GeneratedColumn<String> get voiceLocale => $composableBuilder(
    column: $table.voiceLocale,
    builder: (column) => column,
  );

  GeneratedColumn<double> get speechRate => $composableBuilder(
    column: $table.speechRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get speechPitch => $composableBuilder(
    column: $table.speechPitch,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StudentProfilesTableTableManager
    extends
        RootTableManager<
          _$KhipuDatabase,
          $StudentProfilesTable,
          StudentProfileRow,
          $$StudentProfilesTableFilterComposer,
          $$StudentProfilesTableOrderingComposer,
          $$StudentProfilesTableAnnotationComposer,
          $$StudentProfilesTableCreateCompanionBuilder,
          $$StudentProfilesTableUpdateCompanionBuilder,
          (
            StudentProfileRow,
            BaseReferences<
              _$KhipuDatabase,
              $StudentProfilesTable,
              StudentProfileRow
            >,
          ),
          StudentProfileRow,
          PrefetchHooks Function()
        > {
  $$StudentProfilesTableTableManager(
    _$KhipuDatabase db,
    $StudentProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<String> grade = const Value.absent(),
                Value<String> detectedLevel = const Value.absent(),
                Value<String> levelSource = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<String> learningPreference = const Value.absent(),
                Value<String> defaultResponseDetail = const Value.absent(),
                Value<String?> voiceName = const Value.absent(),
                Value<String> voiceLocale = const Value.absent(),
                Value<double> speechRate = const Value.absent(),
                Value<double> speechPitch = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudentProfilesCompanion(
                id: id,
                age: age,
                grade: grade,
                detectedLevel: detectedLevel,
                levelSource: levelSource,
                locale: locale,
                learningPreference: learningPreference,
                defaultResponseDetail: defaultResponseDetail,
                voiceName: voiceName,
                voiceLocale: voiceLocale,
                speechRate: speechRate,
                speechPitch: speechPitch,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int age,
                required String grade,
                Value<String> detectedLevel = const Value.absent(),
                Value<String> levelSource = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<String> learningPreference = const Value.absent(),
                Value<String> defaultResponseDetail = const Value.absent(),
                Value<String?> voiceName = const Value.absent(),
                Value<String> voiceLocale = const Value.absent(),
                Value<double> speechRate = const Value.absent(),
                Value<double> speechPitch = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => StudentProfilesCompanion.insert(
                id: id,
                age: age,
                grade: grade,
                detectedLevel: detectedLevel,
                levelSource: levelSource,
                locale: locale,
                learningPreference: learningPreference,
                defaultResponseDetail: defaultResponseDetail,
                voiceName: voiceName,
                voiceLocale: voiceLocale,
                speechRate: speechRate,
                speechPitch: speechPitch,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudentProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$KhipuDatabase,
      $StudentProfilesTable,
      StudentProfileRow,
      $$StudentProfilesTableFilterComposer,
      $$StudentProfilesTableOrderingComposer,
      $$StudentProfilesTableAnnotationComposer,
      $$StudentProfilesTableCreateCompanionBuilder,
      $$StudentProfilesTableUpdateCompanionBuilder,
      (
        StudentProfileRow,
        BaseReferences<
          _$KhipuDatabase,
          $StudentProfilesTable,
          StudentProfileRow
        >,
      ),
      StudentProfileRow,
      PrefetchHooks Function()
    >;
typedef $$CoursesTableCreateCompanionBuilder =
    CoursesCompanion Function({
      required String id,
      required String subject,
      required String title,
      required String grade,
      required String educationLevel,
      Value<int> sortOrder,
      Value<bool> enabled,
      Value<int> rowid,
    });
typedef $$CoursesTableUpdateCompanionBuilder =
    CoursesCompanion Function({
      Value<String> id,
      Value<String> subject,
      Value<String> title,
      Value<String> grade,
      Value<String> educationLevel,
      Value<int> sortOrder,
      Value<bool> enabled,
      Value<int> rowid,
    });

final class $$CoursesTableReferences
    extends BaseReferences<_$KhipuDatabase, $CoursesTable, CourseRow> {
  $$CoursesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$NotebooksTable, List<NotebookRow>>
  _notebooksRefsTable(_$KhipuDatabase db) => MultiTypedResultKey.fromTable(
    db.notebooks,
    aliasName: 'courses__id__notebooks__course_id',
  );

  $$NotebooksTableProcessedTableManager get notebooksRefs {
    final manager = $$NotebooksTableTableManager(
      $_db,
      $_db.notebooks,
    ).filter((f) => f.courseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_notebooksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CoursesTableFilterComposer
    extends Composer<_$KhipuDatabase, $CoursesTable> {
  $$CoursesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get educationLevel => $composableBuilder(
    column: $table.educationLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> notebooksRefs(
    Expression<bool> Function($$NotebooksTableFilterComposer f) f,
  ) {
    final $$NotebooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notebooks,
      getReferencedColumn: (t) => t.courseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotebooksTableFilterComposer(
            $db: $db,
            $table: $db.notebooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoursesTableOrderingComposer
    extends Composer<_$KhipuDatabase, $CoursesTable> {
  $$CoursesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get educationLevel => $composableBuilder(
    column: $table.educationLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoursesTableAnnotationComposer
    extends Composer<_$KhipuDatabase, $CoursesTable> {
  $$CoursesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get educationLevel => $composableBuilder(
    column: $table.educationLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  Expression<T> notebooksRefs<T extends Object>(
    Expression<T> Function($$NotebooksTableAnnotationComposer a) f,
  ) {
    final $$NotebooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notebooks,
      getReferencedColumn: (t) => t.courseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotebooksTableAnnotationComposer(
            $db: $db,
            $table: $db.notebooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoursesTableTableManager
    extends
        RootTableManager<
          _$KhipuDatabase,
          $CoursesTable,
          CourseRow,
          $$CoursesTableFilterComposer,
          $$CoursesTableOrderingComposer,
          $$CoursesTableAnnotationComposer,
          $$CoursesTableCreateCompanionBuilder,
          $$CoursesTableUpdateCompanionBuilder,
          (CourseRow, $$CoursesTableReferences),
          CourseRow,
          PrefetchHooks Function({bool notebooksRefs})
        > {
  $$CoursesTableTableManager(_$KhipuDatabase db, $CoursesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoursesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoursesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoursesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> subject = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> grade = const Value.absent(),
                Value<String> educationLevel = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoursesCompanion(
                id: id,
                subject: subject,
                title: title,
                grade: grade,
                educationLevel: educationLevel,
                sortOrder: sortOrder,
                enabled: enabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String subject,
                required String title,
                required String grade,
                required String educationLevel,
                Value<int> sortOrder = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoursesCompanion.insert(
                id: id,
                subject: subject,
                title: title,
                grade: grade,
                educationLevel: educationLevel,
                sortOrder: sortOrder,
                enabled: enabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CoursesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({notebooksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (notebooksRefs) db.notebooks],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (notebooksRefs)
                    await $_getPrefetchedData<
                      CourseRow,
                      $CoursesTable,
                      NotebookRow
                    >(
                      currentTable: table,
                      referencedTable: $$CoursesTableReferences
                          ._notebooksRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CoursesTableReferences(db, table, p0).notebooksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.courseId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CoursesTableProcessedTableManager =
    ProcessedTableManager<
      _$KhipuDatabase,
      $CoursesTable,
      CourseRow,
      $$CoursesTableFilterComposer,
      $$CoursesTableOrderingComposer,
      $$CoursesTableAnnotationComposer,
      $$CoursesTableCreateCompanionBuilder,
      $$CoursesTableUpdateCompanionBuilder,
      (CourseRow, $$CoursesTableReferences),
      CourseRow,
      PrefetchHooks Function({bool notebooksRefs})
    >;
typedef $$NotebooksTableCreateCompanionBuilder =
    NotebooksCompanion Function({
      required String id,
      required String courseId,
      required String title,
      required String topic,
      Value<String?> description,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> archivedAt,
      Value<int> rowid,
    });
typedef $$NotebooksTableUpdateCompanionBuilder =
    NotebooksCompanion Function({
      Value<String> id,
      Value<String> courseId,
      Value<String> title,
      Value<String> topic,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> archivedAt,
      Value<int> rowid,
    });

final class $$NotebooksTableReferences
    extends BaseReferences<_$KhipuDatabase, $NotebooksTable, NotebookRow> {
  $$NotebooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CoursesTable _courseIdTable(_$KhipuDatabase db) =>
      db.courses.createAlias('notebooks__course_id__courses__id');

  $$CoursesTableProcessedTableManager get courseId {
    final $_column = $_itemColumn<String>('course_id')!;

    final manager = $$CoursesTableTableManager(
      $_db,
      $_db.courses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_courseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ChatsTable, List<ChatRow>> _chatsRefsTable(
    _$KhipuDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.chats,
    aliasName: 'notebooks__id__chats__notebook_id',
  );

  $$ChatsTableProcessedTableManager get chatsRefs {
    final manager = $$ChatsTableTableManager(
      $_db,
      $_db.chats,
    ).filter((f) => f.notebookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_chatsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NotebooksTableFilterComposer
    extends Composer<_$KhipuDatabase, $NotebooksTable> {
  $$NotebooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topic => $composableBuilder(
    column: $table.topic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CoursesTableFilterComposer get courseId {
    final $$CoursesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableFilterComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> chatsRefs(
    Expression<bool> Function($$ChatsTableFilterComposer f) f,
  ) {
    final $$ChatsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chats,
      getReferencedColumn: (t) => t.notebookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatsTableFilterComposer(
            $db: $db,
            $table: $db.chats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NotebooksTableOrderingComposer
    extends Composer<_$KhipuDatabase, $NotebooksTable> {
  $$NotebooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topic => $composableBuilder(
    column: $table.topic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoursesTableOrderingComposer get courseId {
    final $$CoursesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableOrderingComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotebooksTableAnnotationComposer
    extends Composer<_$KhipuDatabase, $NotebooksTable> {
  $$NotebooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get topic =>
      $composableBuilder(column: $table.topic, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  $$CoursesTableAnnotationComposer get courseId {
    final $$CoursesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableAnnotationComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> chatsRefs<T extends Object>(
    Expression<T> Function($$ChatsTableAnnotationComposer a) f,
  ) {
    final $$ChatsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chats,
      getReferencedColumn: (t) => t.notebookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatsTableAnnotationComposer(
            $db: $db,
            $table: $db.chats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NotebooksTableTableManager
    extends
        RootTableManager<
          _$KhipuDatabase,
          $NotebooksTable,
          NotebookRow,
          $$NotebooksTableFilterComposer,
          $$NotebooksTableOrderingComposer,
          $$NotebooksTableAnnotationComposer,
          $$NotebooksTableCreateCompanionBuilder,
          $$NotebooksTableUpdateCompanionBuilder,
          (NotebookRow, $$NotebooksTableReferences),
          NotebookRow,
          PrefetchHooks Function({bool courseId, bool chatsRefs})
        > {
  $$NotebooksTableTableManager(_$KhipuDatabase db, $NotebooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotebooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotebooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotebooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> courseId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> topic = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotebooksCompanion(
                id: id,
                courseId: courseId,
                title: title,
                topic: topic,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String courseId,
                required String title,
                required String topic,
                Value<String?> description = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotebooksCompanion.insert(
                id: id,
                courseId: courseId,
                title: title,
                topic: topic,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NotebooksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({courseId = false, chatsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (chatsRefs) db.chats],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (courseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.courseId,
                                referencedTable: $$NotebooksTableReferences
                                    ._courseIdTable(db),
                                referencedColumn: $$NotebooksTableReferences
                                    ._courseIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chatsRefs)
                    await $_getPrefetchedData<
                      NotebookRow,
                      $NotebooksTable,
                      ChatRow
                    >(
                      currentTable: table,
                      referencedTable: $$NotebooksTableReferences
                          ._chatsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$NotebooksTableReferences(db, table, p0).chatsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.notebookId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$NotebooksTableProcessedTableManager =
    ProcessedTableManager<
      _$KhipuDatabase,
      $NotebooksTable,
      NotebookRow,
      $$NotebooksTableFilterComposer,
      $$NotebooksTableOrderingComposer,
      $$NotebooksTableAnnotationComposer,
      $$NotebooksTableCreateCompanionBuilder,
      $$NotebooksTableUpdateCompanionBuilder,
      (NotebookRow, $$NotebooksTableReferences),
      NotebookRow,
      PrefetchHooks Function({bool courseId, bool chatsRefs})
    >;
typedef $$ChatsTableCreateCompanionBuilder =
    ChatsCompanion Function({
      required String id,
      required String notebookId,
      required String title,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ChatsTableUpdateCompanionBuilder =
    ChatsCompanion Function({
      Value<String> id,
      Value<String> notebookId,
      Value<String> title,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ChatsTableReferences
    extends BaseReferences<_$KhipuDatabase, $ChatsTable, ChatRow> {
  $$ChatsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $NotebooksTable _notebookIdTable(_$KhipuDatabase db) =>
      db.notebooks.createAlias('chats__notebook_id__notebooks__id');

  $$NotebooksTableProcessedTableManager get notebookId {
    final $_column = $_itemColumn<String>('notebook_id')!;

    final manager = $$NotebooksTableTableManager(
      $_db,
      $_db.notebooks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_notebookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ChatTurnsTable, List<ChatTurnRow>>
  _chatTurnsRefsTable(_$KhipuDatabase db) => MultiTypedResultKey.fromTable(
    db.chatTurns,
    aliasName: 'chats__id__chat_turns__chat_id',
  );

  $$ChatTurnsTableProcessedTableManager get chatTurnsRefs {
    final manager = $$ChatTurnsTableTableManager(
      $_db,
      $_db.chatTurns,
    ).filter((f) => f.chatId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_chatTurnsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChatsTableFilterComposer
    extends Composer<_$KhipuDatabase, $ChatsTable> {
  $$ChatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$NotebooksTableFilterComposer get notebookId {
    final $$NotebooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.notebookId,
      referencedTable: $db.notebooks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotebooksTableFilterComposer(
            $db: $db,
            $table: $db.notebooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> chatTurnsRefs(
    Expression<bool> Function($$ChatTurnsTableFilterComposer f) f,
  ) {
    final $$ChatTurnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatTurns,
      getReferencedColumn: (t) => t.chatId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatTurnsTableFilterComposer(
            $db: $db,
            $table: $db.chatTurns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChatsTableOrderingComposer
    extends Composer<_$KhipuDatabase, $ChatsTable> {
  $$ChatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$NotebooksTableOrderingComposer get notebookId {
    final $$NotebooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.notebookId,
      referencedTable: $db.notebooks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotebooksTableOrderingComposer(
            $db: $db,
            $table: $db.notebooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatsTableAnnotationComposer
    extends Composer<_$KhipuDatabase, $ChatsTable> {
  $$ChatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$NotebooksTableAnnotationComposer get notebookId {
    final $$NotebooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.notebookId,
      referencedTable: $db.notebooks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotebooksTableAnnotationComposer(
            $db: $db,
            $table: $db.notebooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> chatTurnsRefs<T extends Object>(
    Expression<T> Function($$ChatTurnsTableAnnotationComposer a) f,
  ) {
    final $$ChatTurnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatTurns,
      getReferencedColumn: (t) => t.chatId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatTurnsTableAnnotationComposer(
            $db: $db,
            $table: $db.chatTurns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChatsTableTableManager
    extends
        RootTableManager<
          _$KhipuDatabase,
          $ChatsTable,
          ChatRow,
          $$ChatsTableFilterComposer,
          $$ChatsTableOrderingComposer,
          $$ChatsTableAnnotationComposer,
          $$ChatsTableCreateCompanionBuilder,
          $$ChatsTableUpdateCompanionBuilder,
          (ChatRow, $$ChatsTableReferences),
          ChatRow,
          PrefetchHooks Function({bool notebookId, bool chatTurnsRefs})
        > {
  $$ChatsTableTableManager(_$KhipuDatabase db, $ChatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> notebookId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatsCompanion(
                id: id,
                notebookId: notebookId,
                title: title,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String notebookId,
                required String title,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ChatsCompanion.insert(
                id: id,
                notebookId: notebookId,
                title: title,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ChatsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({notebookId = false, chatTurnsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (chatTurnsRefs) db.chatTurns],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (notebookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.notebookId,
                                referencedTable: $$ChatsTableReferences
                                    ._notebookIdTable(db),
                                referencedColumn: $$ChatsTableReferences
                                    ._notebookIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chatTurnsRefs)
                    await $_getPrefetchedData<
                      ChatRow,
                      $ChatsTable,
                      ChatTurnRow
                    >(
                      currentTable: table,
                      referencedTable: $$ChatsTableReferences
                          ._chatTurnsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ChatsTableReferences(db, table, p0).chatTurnsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.chatId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ChatsTableProcessedTableManager =
    ProcessedTableManager<
      _$KhipuDatabase,
      $ChatsTable,
      ChatRow,
      $$ChatsTableFilterComposer,
      $$ChatsTableOrderingComposer,
      $$ChatsTableAnnotationComposer,
      $$ChatsTableCreateCompanionBuilder,
      $$ChatsTableUpdateCompanionBuilder,
      (ChatRow, $$ChatsTableReferences),
      ChatRow,
      PrefetchHooks Function({bool notebookId, bool chatTurnsRefs})
    >;
typedef $$ChatTurnsTableCreateCompanionBuilder =
    ChatTurnsCompanion Function({
      required String id,
      required String chatId,
      required int position,
      required String userQuestion,
      Value<String?> lessonScriptJson,
      Value<String?> narrationText,
      required String profileSnapshotJson,
      required String learningContextJson,
      required String responseDetail,
      required String engine,
      Value<String> status,
      Value<String?> errorMessage,
      required DateTime createdAt,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });
typedef $$ChatTurnsTableUpdateCompanionBuilder =
    ChatTurnsCompanion Function({
      Value<String> id,
      Value<String> chatId,
      Value<int> position,
      Value<String> userQuestion,
      Value<String?> lessonScriptJson,
      Value<String?> narrationText,
      Value<String> profileSnapshotJson,
      Value<String> learningContextJson,
      Value<String> responseDetail,
      Value<String> engine,
      Value<String> status,
      Value<String?> errorMessage,
      Value<DateTime> createdAt,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });

final class $$ChatTurnsTableReferences
    extends BaseReferences<_$KhipuDatabase, $ChatTurnsTable, ChatTurnRow> {
  $$ChatTurnsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChatsTable _chatIdTable(_$KhipuDatabase db) =>
      db.chats.createAlias('chat_turns__chat_id__chats__id');

  $$ChatsTableProcessedTableManager get chatId {
    final $_column = $_itemColumn<String>('chat_id')!;

    final manager = $$ChatsTableTableManager(
      $_db,
      $_db.chats,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatTurnsTableFilterComposer
    extends Composer<_$KhipuDatabase, $ChatTurnsTable> {
  $$ChatTurnsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userQuestion => $composableBuilder(
    column: $table.userQuestion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lessonScriptJson => $composableBuilder(
    column: $table.lessonScriptJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get narrationText => $composableBuilder(
    column: $table.narrationText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileSnapshotJson => $composableBuilder(
    column: $table.profileSnapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get learningContextJson => $composableBuilder(
    column: $table.learningContextJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get responseDetail => $composableBuilder(
    column: $table.responseDetail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get engine => $composableBuilder(
    column: $table.engine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ChatsTableFilterComposer get chatId {
    final $$ChatsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chats,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatsTableFilterComposer(
            $db: $db,
            $table: $db.chats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatTurnsTableOrderingComposer
    extends Composer<_$KhipuDatabase, $ChatTurnsTable> {
  $$ChatTurnsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userQuestion => $composableBuilder(
    column: $table.userQuestion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lessonScriptJson => $composableBuilder(
    column: $table.lessonScriptJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get narrationText => $composableBuilder(
    column: $table.narrationText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileSnapshotJson => $composableBuilder(
    column: $table.profileSnapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get learningContextJson => $composableBuilder(
    column: $table.learningContextJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get responseDetail => $composableBuilder(
    column: $table.responseDetail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get engine => $composableBuilder(
    column: $table.engine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChatsTableOrderingComposer get chatId {
    final $$ChatsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chats,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatsTableOrderingComposer(
            $db: $db,
            $table: $db.chats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatTurnsTableAnnotationComposer
    extends Composer<_$KhipuDatabase, $ChatTurnsTable> {
  $$ChatTurnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get userQuestion => $composableBuilder(
    column: $table.userQuestion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lessonScriptJson => $composableBuilder(
    column: $table.lessonScriptJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get narrationText => $composableBuilder(
    column: $table.narrationText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get profileSnapshotJson => $composableBuilder(
    column: $table.profileSnapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get learningContextJson => $composableBuilder(
    column: $table.learningContextJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get responseDetail => $composableBuilder(
    column: $table.responseDetail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get engine =>
      $composableBuilder(column: $table.engine, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$ChatsTableAnnotationComposer get chatId {
    final $$ChatsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chats,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatsTableAnnotationComposer(
            $db: $db,
            $table: $db.chats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatTurnsTableTableManager
    extends
        RootTableManager<
          _$KhipuDatabase,
          $ChatTurnsTable,
          ChatTurnRow,
          $$ChatTurnsTableFilterComposer,
          $$ChatTurnsTableOrderingComposer,
          $$ChatTurnsTableAnnotationComposer,
          $$ChatTurnsTableCreateCompanionBuilder,
          $$ChatTurnsTableUpdateCompanionBuilder,
          (ChatTurnRow, $$ChatTurnsTableReferences),
          ChatTurnRow,
          PrefetchHooks Function({bool chatId})
        > {
  $$ChatTurnsTableTableManager(_$KhipuDatabase db, $ChatTurnsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatTurnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatTurnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatTurnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> chatId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> userQuestion = const Value.absent(),
                Value<String?> lessonScriptJson = const Value.absent(),
                Value<String?> narrationText = const Value.absent(),
                Value<String> profileSnapshotJson = const Value.absent(),
                Value<String> learningContextJson = const Value.absent(),
                Value<String> responseDetail = const Value.absent(),
                Value<String> engine = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatTurnsCompanion(
                id: id,
                chatId: chatId,
                position: position,
                userQuestion: userQuestion,
                lessonScriptJson: lessonScriptJson,
                narrationText: narrationText,
                profileSnapshotJson: profileSnapshotJson,
                learningContextJson: learningContextJson,
                responseDetail: responseDetail,
                engine: engine,
                status: status,
                errorMessage: errorMessage,
                createdAt: createdAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String chatId,
                required int position,
                required String userQuestion,
                Value<String?> lessonScriptJson = const Value.absent(),
                Value<String?> narrationText = const Value.absent(),
                required String profileSnapshotJson,
                required String learningContextJson,
                required String responseDetail,
                required String engine,
                Value<String> status = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatTurnsCompanion.insert(
                id: id,
                chatId: chatId,
                position: position,
                userQuestion: userQuestion,
                lessonScriptJson: lessonScriptJson,
                narrationText: narrationText,
                profileSnapshotJson: profileSnapshotJson,
                learningContextJson: learningContextJson,
                responseDetail: responseDetail,
                engine: engine,
                status: status,
                errorMessage: errorMessage,
                createdAt: createdAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChatTurnsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({chatId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (chatId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.chatId,
                                referencedTable: $$ChatTurnsTableReferences
                                    ._chatIdTable(db),
                                referencedColumn: $$ChatTurnsTableReferences
                                    ._chatIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChatTurnsTableProcessedTableManager =
    ProcessedTableManager<
      _$KhipuDatabase,
      $ChatTurnsTable,
      ChatTurnRow,
      $$ChatTurnsTableFilterComposer,
      $$ChatTurnsTableOrderingComposer,
      $$ChatTurnsTableAnnotationComposer,
      $$ChatTurnsTableCreateCompanionBuilder,
      $$ChatTurnsTableUpdateCompanionBuilder,
      (ChatTurnRow, $$ChatTurnsTableReferences),
      ChatTurnRow,
      PrefetchHooks Function({bool chatId})
    >;

class $KhipuDatabaseManager {
  final _$KhipuDatabase _db;
  $KhipuDatabaseManager(this._db);
  $$StudentProfilesTableTableManager get studentProfiles =>
      $$StudentProfilesTableTableManager(_db, _db.studentProfiles);
  $$CoursesTableTableManager get courses =>
      $$CoursesTableTableManager(_db, _db.courses);
  $$NotebooksTableTableManager get notebooks =>
      $$NotebooksTableTableManager(_db, _db.notebooks);
  $$ChatsTableTableManager get chats =>
      $$ChatsTableTableManager(_db, _db.chats);
  $$ChatTurnsTableTableManager get chatTurns =>
      $$ChatTurnsTableTableManager(_db, _db.chatTurns);
}
