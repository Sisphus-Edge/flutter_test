// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dailyrecord_db_manager.dart';

// ignore_for_file: type=lint
class DailyRecords extends Table with TableInfo<DailyRecords, DailyRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DailyRecords(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _recordDateMeta =
      const VerificationMeta('recordDate');
  late final GeneratedColumn<DateTime> recordDate = GeneratedColumn<DateTime>(
      'RecordDate', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _exerciseGoalMeta =
      const VerificationMeta('exerciseGoal');
  late final GeneratedColumn<int> exerciseGoal = GeneratedColumn<int>(
      'exercise_goal', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _exerciseCompletedMeta =
      const VerificationMeta('exerciseCompleted');
  late final GeneratedColumn<int> exerciseCompleted = GeneratedColumn<int>(
      'exercise_completed', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _nutritionGoalMeta =
      const VerificationMeta('nutritionGoal');
  late final GeneratedColumn<int> nutritionGoal = GeneratedColumn<int>(
      'nutrition_goal', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _nutritionCompletedMeta =
      const VerificationMeta('nutritionCompleted');
  late final GeneratedColumn<int> nutritionCompleted = GeneratedColumn<int>(
      'nutrition_completed', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _waterGoalMeta =
      const VerificationMeta('waterGoal');
  late final GeneratedColumn<int> waterGoal = GeneratedColumn<int>(
      'water_goal', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _waterCompletedMeta =
      const VerificationMeta('waterCompleted');
  late final GeneratedColumn<int> waterCompleted = GeneratedColumn<int>(
      'water_completed', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        recordDate,
        exerciseGoal,
        exerciseCompleted,
        nutritionGoal,
        nutritionCompleted,
        waterGoal,
        waterCompleted,
        score
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_records';
  @override
  VerificationContext validateIntegrity(Insertable<DailyRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('RecordDate')) {
      context.handle(
          _recordDateMeta,
          recordDate.isAcceptableOrUnknown(
              data['RecordDate']!, _recordDateMeta));
    } else if (isInserting) {
      context.missing(_recordDateMeta);
    }
    if (data.containsKey('exercise_goal')) {
      context.handle(
          _exerciseGoalMeta,
          exerciseGoal.isAcceptableOrUnknown(
              data['exercise_goal']!, _exerciseGoalMeta));
    }
    if (data.containsKey('exercise_completed')) {
      context.handle(
          _exerciseCompletedMeta,
          exerciseCompleted.isAcceptableOrUnknown(
              data['exercise_completed']!, _exerciseCompletedMeta));
    }
    if (data.containsKey('nutrition_goal')) {
      context.handle(
          _nutritionGoalMeta,
          nutritionGoal.isAcceptableOrUnknown(
              data['nutrition_goal']!, _nutritionGoalMeta));
    }
    if (data.containsKey('nutrition_completed')) {
      context.handle(
          _nutritionCompletedMeta,
          nutritionCompleted.isAcceptableOrUnknown(
              data['nutrition_completed']!, _nutritionCompletedMeta));
    }
    if (data.containsKey('water_goal')) {
      context.handle(_waterGoalMeta,
          waterGoal.isAcceptableOrUnknown(data['water_goal']!, _waterGoalMeta));
    }
    if (data.containsKey('water_completed')) {
      context.handle(
          _waterCompletedMeta,
          waterCompleted.isAcceptableOrUnknown(
              data['water_completed']!, _waterCompletedMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {recordDate};
  @override
  DailyRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyRecord(
      recordDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}RecordDate'])!,
      exerciseGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_goal']),
      exerciseCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_completed']),
      nutritionGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}nutrition_goal']),
      nutritionCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}nutrition_completed']),
      waterGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}water_goal']),
      waterCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}water_completed']),
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score']),
    );
  }

  @override
  DailyRecords createAlias(String alias) {
    return DailyRecords(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class DailyRecord extends DataClass implements Insertable<DailyRecord> {
  final DateTime recordDate;
  final int? exerciseGoal;
  final int? exerciseCompleted;
  final int? nutritionGoal;
  final int? nutritionCompleted;
  final int? waterGoal;
  final int? waterCompleted;
  final int? score;
  const DailyRecord(
      {required this.recordDate,
      this.exerciseGoal,
      this.exerciseCompleted,
      this.nutritionGoal,
      this.nutritionCompleted,
      this.waterGoal,
      this.waterCompleted,
      this.score});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['RecordDate'] = Variable<DateTime>(recordDate);
    if (!nullToAbsent || exerciseGoal != null) {
      map['exercise_goal'] = Variable<int>(exerciseGoal);
    }
    if (!nullToAbsent || exerciseCompleted != null) {
      map['exercise_completed'] = Variable<int>(exerciseCompleted);
    }
    if (!nullToAbsent || nutritionGoal != null) {
      map['nutrition_goal'] = Variable<int>(nutritionGoal);
    }
    if (!nullToAbsent || nutritionCompleted != null) {
      map['nutrition_completed'] = Variable<int>(nutritionCompleted);
    }
    if (!nullToAbsent || waterGoal != null) {
      map['water_goal'] = Variable<int>(waterGoal);
    }
    if (!nullToAbsent || waterCompleted != null) {
      map['water_completed'] = Variable<int>(waterCompleted);
    }
    if (!nullToAbsent || score != null) {
      map['score'] = Variable<int>(score);
    }
    return map;
  }

  DailyRecordsCompanion toCompanion(bool nullToAbsent) {
    return DailyRecordsCompanion(
      recordDate: Value(recordDate),
      exerciseGoal: exerciseGoal == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseGoal),
      exerciseCompleted: exerciseCompleted == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseCompleted),
      nutritionGoal: nutritionGoal == null && nullToAbsent
          ? const Value.absent()
          : Value(nutritionGoal),
      nutritionCompleted: nutritionCompleted == null && nullToAbsent
          ? const Value.absent()
          : Value(nutritionCompleted),
      waterGoal: waterGoal == null && nullToAbsent
          ? const Value.absent()
          : Value(waterGoal),
      waterCompleted: waterCompleted == null && nullToAbsent
          ? const Value.absent()
          : Value(waterCompleted),
      score:
          score == null && nullToAbsent ? const Value.absent() : Value(score),
    );
  }

  factory DailyRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyRecord(
      recordDate: serializer.fromJson<DateTime>(json['RecordDate']),
      exerciseGoal: serializer.fromJson<int?>(json['exercise_goal']),
      exerciseCompleted: serializer.fromJson<int?>(json['exercise_completed']),
      nutritionGoal: serializer.fromJson<int?>(json['nutrition_goal']),
      nutritionCompleted:
          serializer.fromJson<int?>(json['nutrition_completed']),
      waterGoal: serializer.fromJson<int?>(json['water_goal']),
      waterCompleted: serializer.fromJson<int?>(json['water_completed']),
      score: serializer.fromJson<int?>(json['score']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'RecordDate': serializer.toJson<DateTime>(recordDate),
      'exercise_goal': serializer.toJson<int?>(exerciseGoal),
      'exercise_completed': serializer.toJson<int?>(exerciseCompleted),
      'nutrition_goal': serializer.toJson<int?>(nutritionGoal),
      'nutrition_completed': serializer.toJson<int?>(nutritionCompleted),
      'water_goal': serializer.toJson<int?>(waterGoal),
      'water_completed': serializer.toJson<int?>(waterCompleted),
      'score': serializer.toJson<int?>(score),
    };
  }

  DailyRecord copyWith(
          {DateTime? recordDate,
          Value<int?> exerciseGoal = const Value.absent(),
          Value<int?> exerciseCompleted = const Value.absent(),
          Value<int?> nutritionGoal = const Value.absent(),
          Value<int?> nutritionCompleted = const Value.absent(),
          Value<int?> waterGoal = const Value.absent(),
          Value<int?> waterCompleted = const Value.absent(),
          Value<int?> score = const Value.absent()}) =>
      DailyRecord(
        recordDate: recordDate ?? this.recordDate,
        exerciseGoal:
            exerciseGoal.present ? exerciseGoal.value : this.exerciseGoal,
        exerciseCompleted: exerciseCompleted.present
            ? exerciseCompleted.value
            : this.exerciseCompleted,
        nutritionGoal:
            nutritionGoal.present ? nutritionGoal.value : this.nutritionGoal,
        nutritionCompleted: nutritionCompleted.present
            ? nutritionCompleted.value
            : this.nutritionCompleted,
        waterGoal: waterGoal.present ? waterGoal.value : this.waterGoal,
        waterCompleted:
            waterCompleted.present ? waterCompleted.value : this.waterCompleted,
        score: score.present ? score.value : this.score,
      );
  @override
  String toString() {
    return (StringBuffer('DailyRecord(')
          ..write('recordDate: $recordDate, ')
          ..write('exerciseGoal: $exerciseGoal, ')
          ..write('exerciseCompleted: $exerciseCompleted, ')
          ..write('nutritionGoal: $nutritionGoal, ')
          ..write('nutritionCompleted: $nutritionCompleted, ')
          ..write('waterGoal: $waterGoal, ')
          ..write('waterCompleted: $waterCompleted, ')
          ..write('score: $score')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(recordDate, exerciseGoal, exerciseCompleted,
      nutritionGoal, nutritionCompleted, waterGoal, waterCompleted, score);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyRecord &&
          other.recordDate == this.recordDate &&
          other.exerciseGoal == this.exerciseGoal &&
          other.exerciseCompleted == this.exerciseCompleted &&
          other.nutritionGoal == this.nutritionGoal &&
          other.nutritionCompleted == this.nutritionCompleted &&
          other.waterGoal == this.waterGoal &&
          other.waterCompleted == this.waterCompleted &&
          other.score == this.score);
}

class DailyRecordsCompanion extends UpdateCompanion<DailyRecord> {
  final Value<DateTime> recordDate;
  final Value<int?> exerciseGoal;
  final Value<int?> exerciseCompleted;
  final Value<int?> nutritionGoal;
  final Value<int?> nutritionCompleted;
  final Value<int?> waterGoal;
  final Value<int?> waterCompleted;
  final Value<int?> score;
  final Value<int> rowid;
  const DailyRecordsCompanion({
    this.recordDate = const Value.absent(),
    this.exerciseGoal = const Value.absent(),
    this.exerciseCompleted = const Value.absent(),
    this.nutritionGoal = const Value.absent(),
    this.nutritionCompleted = const Value.absent(),
    this.waterGoal = const Value.absent(),
    this.waterCompleted = const Value.absent(),
    this.score = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyRecordsCompanion.insert({
    required DateTime recordDate,
    this.exerciseGoal = const Value.absent(),
    this.exerciseCompleted = const Value.absent(),
    this.nutritionGoal = const Value.absent(),
    this.nutritionCompleted = const Value.absent(),
    this.waterGoal = const Value.absent(),
    this.waterCompleted = const Value.absent(),
    this.score = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : recordDate = Value(recordDate);
  static Insertable<DailyRecord> custom({
    Expression<DateTime>? recordDate,
    Expression<int>? exerciseGoal,
    Expression<int>? exerciseCompleted,
    Expression<int>? nutritionGoal,
    Expression<int>? nutritionCompleted,
    Expression<int>? waterGoal,
    Expression<int>? waterCompleted,
    Expression<int>? score,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (recordDate != null) 'RecordDate': recordDate,
      if (exerciseGoal != null) 'exercise_goal': exerciseGoal,
      if (exerciseCompleted != null) 'exercise_completed': exerciseCompleted,
      if (nutritionGoal != null) 'nutrition_goal': nutritionGoal,
      if (nutritionCompleted != null) 'nutrition_completed': nutritionCompleted,
      if (waterGoal != null) 'water_goal': waterGoal,
      if (waterCompleted != null) 'water_completed': waterCompleted,
      if (score != null) 'score': score,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyRecordsCompanion copyWith(
      {Value<DateTime>? recordDate,
      Value<int?>? exerciseGoal,
      Value<int?>? exerciseCompleted,
      Value<int?>? nutritionGoal,
      Value<int?>? nutritionCompleted,
      Value<int?>? waterGoal,
      Value<int?>? waterCompleted,
      Value<int?>? score,
      Value<int>? rowid}) {
    return DailyRecordsCompanion(
      recordDate: recordDate ?? this.recordDate,
      exerciseGoal: exerciseGoal ?? this.exerciseGoal,
      exerciseCompleted: exerciseCompleted ?? this.exerciseCompleted,
      nutritionGoal: nutritionGoal ?? this.nutritionGoal,
      nutritionCompleted: nutritionCompleted ?? this.nutritionCompleted,
      waterGoal: waterGoal ?? this.waterGoal,
      waterCompleted: waterCompleted ?? this.waterCompleted,
      score: score ?? this.score,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (recordDate.present) {
      map['RecordDate'] = Variable<DateTime>(recordDate.value);
    }
    if (exerciseGoal.present) {
      map['exercise_goal'] = Variable<int>(exerciseGoal.value);
    }
    if (exerciseCompleted.present) {
      map['exercise_completed'] = Variable<int>(exerciseCompleted.value);
    }
    if (nutritionGoal.present) {
      map['nutrition_goal'] = Variable<int>(nutritionGoal.value);
    }
    if (nutritionCompleted.present) {
      map['nutrition_completed'] = Variable<int>(nutritionCompleted.value);
    }
    if (waterGoal.present) {
      map['water_goal'] = Variable<int>(waterGoal.value);
    }
    if (waterCompleted.present) {
      map['water_completed'] = Variable<int>(waterCompleted.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyRecordsCompanion(')
          ..write('recordDate: $recordDate, ')
          ..write('exerciseGoal: $exerciseGoal, ')
          ..write('exerciseCompleted: $exerciseCompleted, ')
          ..write('nutritionGoal: $nutritionGoal, ')
          ..write('nutritionCompleted: $nutritionCompleted, ')
          ..write('waterGoal: $waterGoal, ')
          ..write('waterCompleted: $waterCompleted, ')
          ..write('score: $score, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Habits extends Table with TableInfo<Habits, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Habits(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _habitIdMeta =
      const VerificationMeta('habitId');
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
      'HabitId', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _habitNameMeta =
      const VerificationMeta('habitName');
  late final GeneratedColumn<String> habitName = GeneratedColumn<String>(
      'HabitName', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _mondayMeta = const VerificationMeta('monday');
  late final GeneratedColumn<bool> monday = GeneratedColumn<bool>(
      'monday', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _tuesdayMeta =
      const VerificationMeta('tuesday');
  late final GeneratedColumn<bool> tuesday = GeneratedColumn<bool>(
      'tuesday', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _wednesdayMeta =
      const VerificationMeta('wednesday');
  late final GeneratedColumn<bool> wednesday = GeneratedColumn<bool>(
      'wednesday', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _thursdayMeta =
      const VerificationMeta('thursday');
  late final GeneratedColumn<bool> thursday = GeneratedColumn<bool>(
      'thursday', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _fridayMeta = const VerificationMeta('friday');
  late final GeneratedColumn<bool> friday = GeneratedColumn<bool>(
      'friday', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _saturdayMeta =
      const VerificationMeta('saturday');
  late final GeneratedColumn<bool> saturday = GeneratedColumn<bool>(
      'saturday', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _sundayMeta = const VerificationMeta('sunday');
  late final GeneratedColumn<bool> sunday = GeneratedColumn<bool>(
      'sunday', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        habitId,
        habitName,
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday,
        sunday,
        startDate,
        endDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(Insertable<Habit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('HabitId')) {
      context.handle(_habitIdMeta,
          habitId.isAcceptableOrUnknown(data['HabitId']!, _habitIdMeta));
    }
    if (data.containsKey('HabitName')) {
      context.handle(_habitNameMeta,
          habitName.isAcceptableOrUnknown(data['HabitName']!, _habitNameMeta));
    }
    if (data.containsKey('monday')) {
      context.handle(_mondayMeta,
          monday.isAcceptableOrUnknown(data['monday']!, _mondayMeta));
    }
    if (data.containsKey('tuesday')) {
      context.handle(_tuesdayMeta,
          tuesday.isAcceptableOrUnknown(data['tuesday']!, _tuesdayMeta));
    }
    if (data.containsKey('wednesday')) {
      context.handle(_wednesdayMeta,
          wednesday.isAcceptableOrUnknown(data['wednesday']!, _wednesdayMeta));
    }
    if (data.containsKey('thursday')) {
      context.handle(_thursdayMeta,
          thursday.isAcceptableOrUnknown(data['thursday']!, _thursdayMeta));
    }
    if (data.containsKey('friday')) {
      context.handle(_fridayMeta,
          friday.isAcceptableOrUnknown(data['friday']!, _fridayMeta));
    }
    if (data.containsKey('saturday')) {
      context.handle(_saturdayMeta,
          saturday.isAcceptableOrUnknown(data['saturday']!, _saturdayMeta));
    }
    if (data.containsKey('sunday')) {
      context.handle(_sundayMeta,
          sunday.isAcceptableOrUnknown(data['sunday']!, _sundayMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {habitId};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      habitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}HabitId'])!,
      habitName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}HabitName']),
      monday: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}monday']),
      tuesday: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}tuesday']),
      wednesday: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}wednesday']),
      thursday: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}thursday']),
      friday: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}friday']),
      saturday: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}saturday']),
      sunday: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sunday']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
    );
  }

  @override
  Habits createAlias(String alias) {
    return Habits(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Habit extends DataClass implements Insertable<Habit> {
  final int habitId;
  final String? habitName;
  final bool? monday;
  final bool? tuesday;
  final bool? wednesday;
  final bool? thursday;
  final bool? friday;
  final bool? saturday;
  final bool? sunday;
  final DateTime? startDate;
  final DateTime? endDate;
  const Habit(
      {required this.habitId,
      this.habitName,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday,
      this.startDate,
      this.endDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['HabitId'] = Variable<int>(habitId);
    if (!nullToAbsent || habitName != null) {
      map['HabitName'] = Variable<String>(habitName);
    }
    if (!nullToAbsent || monday != null) {
      map['monday'] = Variable<bool>(monday);
    }
    if (!nullToAbsent || tuesday != null) {
      map['tuesday'] = Variable<bool>(tuesday);
    }
    if (!nullToAbsent || wednesday != null) {
      map['wednesday'] = Variable<bool>(wednesday);
    }
    if (!nullToAbsent || thursday != null) {
      map['thursday'] = Variable<bool>(thursday);
    }
    if (!nullToAbsent || friday != null) {
      map['friday'] = Variable<bool>(friday);
    }
    if (!nullToAbsent || saturday != null) {
      map['saturday'] = Variable<bool>(saturday);
    }
    if (!nullToAbsent || sunday != null) {
      map['sunday'] = Variable<bool>(sunday);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      habitId: Value(habitId),
      habitName: habitName == null && nullToAbsent
          ? const Value.absent()
          : Value(habitName),
      monday:
          monday == null && nullToAbsent ? const Value.absent() : Value(monday),
      tuesday: tuesday == null && nullToAbsent
          ? const Value.absent()
          : Value(tuesday),
      wednesday: wednesday == null && nullToAbsent
          ? const Value.absent()
          : Value(wednesday),
      thursday: thursday == null && nullToAbsent
          ? const Value.absent()
          : Value(thursday),
      friday:
          friday == null && nullToAbsent ? const Value.absent() : Value(friday),
      saturday: saturday == null && nullToAbsent
          ? const Value.absent()
          : Value(saturday),
      sunday:
          sunday == null && nullToAbsent ? const Value.absent() : Value(sunday),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      habitId: serializer.fromJson<int>(json['HabitId']),
      habitName: serializer.fromJson<String?>(json['HabitName']),
      monday: serializer.fromJson<bool?>(json['monday']),
      tuesday: serializer.fromJson<bool?>(json['tuesday']),
      wednesday: serializer.fromJson<bool?>(json['wednesday']),
      thursday: serializer.fromJson<bool?>(json['thursday']),
      friday: serializer.fromJson<bool?>(json['friday']),
      saturday: serializer.fromJson<bool?>(json['saturday']),
      sunday: serializer.fromJson<bool?>(json['sunday']),
      startDate: serializer.fromJson<DateTime?>(json['start_date']),
      endDate: serializer.fromJson<DateTime?>(json['end_date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'HabitId': serializer.toJson<int>(habitId),
      'HabitName': serializer.toJson<String?>(habitName),
      'monday': serializer.toJson<bool?>(monday),
      'tuesday': serializer.toJson<bool?>(tuesday),
      'wednesday': serializer.toJson<bool?>(wednesday),
      'thursday': serializer.toJson<bool?>(thursday),
      'friday': serializer.toJson<bool?>(friday),
      'saturday': serializer.toJson<bool?>(saturday),
      'sunday': serializer.toJson<bool?>(sunday),
      'start_date': serializer.toJson<DateTime?>(startDate),
      'end_date': serializer.toJson<DateTime?>(endDate),
    };
  }

  Habit copyWith(
          {int? habitId,
          Value<String?> habitName = const Value.absent(),
          Value<bool?> monday = const Value.absent(),
          Value<bool?> tuesday = const Value.absent(),
          Value<bool?> wednesday = const Value.absent(),
          Value<bool?> thursday = const Value.absent(),
          Value<bool?> friday = const Value.absent(),
          Value<bool?> saturday = const Value.absent(),
          Value<bool?> sunday = const Value.absent(),
          Value<DateTime?> startDate = const Value.absent(),
          Value<DateTime?> endDate = const Value.absent()}) =>
      Habit(
        habitId: habitId ?? this.habitId,
        habitName: habitName.present ? habitName.value : this.habitName,
        monday: monday.present ? monday.value : this.monday,
        tuesday: tuesday.present ? tuesday.value : this.tuesday,
        wednesday: wednesday.present ? wednesday.value : this.wednesday,
        thursday: thursday.present ? thursday.value : this.thursday,
        friday: friday.present ? friday.value : this.friday,
        saturday: saturday.present ? saturday.value : this.saturday,
        sunday: sunday.present ? sunday.value : this.sunday,
        startDate: startDate.present ? startDate.value : this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
      );
  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('habitId: $habitId, ')
          ..write('habitName: $habitName, ')
          ..write('monday: $monday, ')
          ..write('tuesday: $tuesday, ')
          ..write('wednesday: $wednesday, ')
          ..write('thursday: $thursday, ')
          ..write('friday: $friday, ')
          ..write('saturday: $saturday, ')
          ..write('sunday: $sunday, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(habitId, habitName, monday, tuesday,
      wednesday, thursday, friday, saturday, sunday, startDate, endDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.habitId == this.habitId &&
          other.habitName == this.habitName &&
          other.monday == this.monday &&
          other.tuesday == this.tuesday &&
          other.wednesday == this.wednesday &&
          other.thursday == this.thursday &&
          other.friday == this.friday &&
          other.saturday == this.saturday &&
          other.sunday == this.sunday &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> habitId;
  final Value<String?> habitName;
  final Value<bool?> monday;
  final Value<bool?> tuesday;
  final Value<bool?> wednesday;
  final Value<bool?> thursday;
  final Value<bool?> friday;
  final Value<bool?> saturday;
  final Value<bool?> sunday;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  const HabitsCompanion({
    this.habitId = const Value.absent(),
    this.habitName = const Value.absent(),
    this.monday = const Value.absent(),
    this.tuesday = const Value.absent(),
    this.wednesday = const Value.absent(),
    this.thursday = const Value.absent(),
    this.friday = const Value.absent(),
    this.saturday = const Value.absent(),
    this.sunday = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.habitId = const Value.absent(),
    this.habitName = const Value.absent(),
    this.monday = const Value.absent(),
    this.tuesday = const Value.absent(),
    this.wednesday = const Value.absent(),
    this.thursday = const Value.absent(),
    this.friday = const Value.absent(),
    this.saturday = const Value.absent(),
    this.sunday = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
  });
  static Insertable<Habit> custom({
    Expression<int>? habitId,
    Expression<String>? habitName,
    Expression<bool>? monday,
    Expression<bool>? tuesday,
    Expression<bool>? wednesday,
    Expression<bool>? thursday,
    Expression<bool>? friday,
    Expression<bool>? saturday,
    Expression<bool>? sunday,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
  }) {
    return RawValuesInsertable({
      if (habitId != null) 'HabitId': habitId,
      if (habitName != null) 'HabitName': habitName,
      if (monday != null) 'monday': monday,
      if (tuesday != null) 'tuesday': tuesday,
      if (wednesday != null) 'wednesday': wednesday,
      if (thursday != null) 'thursday': thursday,
      if (friday != null) 'friday': friday,
      if (saturday != null) 'saturday': saturday,
      if (sunday != null) 'sunday': sunday,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
    });
  }

  HabitsCompanion copyWith(
      {Value<int>? habitId,
      Value<String?>? habitName,
      Value<bool?>? monday,
      Value<bool?>? tuesday,
      Value<bool?>? wednesday,
      Value<bool?>? thursday,
      Value<bool?>? friday,
      Value<bool?>? saturday,
      Value<bool?>? sunday,
      Value<DateTime?>? startDate,
      Value<DateTime?>? endDate}) {
    return HabitsCompanion(
      habitId: habitId ?? this.habitId,
      habitName: habitName ?? this.habitName,
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      sunday: sunday ?? this.sunday,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (habitId.present) {
      map['HabitId'] = Variable<int>(habitId.value);
    }
    if (habitName.present) {
      map['HabitName'] = Variable<String>(habitName.value);
    }
    if (monday.present) {
      map['monday'] = Variable<bool>(monday.value);
    }
    if (tuesday.present) {
      map['tuesday'] = Variable<bool>(tuesday.value);
    }
    if (wednesday.present) {
      map['wednesday'] = Variable<bool>(wednesday.value);
    }
    if (thursday.present) {
      map['thursday'] = Variable<bool>(thursday.value);
    }
    if (friday.present) {
      map['friday'] = Variable<bool>(friday.value);
    }
    if (saturday.present) {
      map['saturday'] = Variable<bool>(saturday.value);
    }
    if (sunday.present) {
      map['sunday'] = Variable<bool>(sunday.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('habitId: $habitId, ')
          ..write('habitName: $habitName, ')
          ..write('monday: $monday, ')
          ..write('tuesday: $tuesday, ')
          ..write('wednesday: $wednesday, ')
          ..write('thursday: $thursday, ')
          ..write('friday: $friday, ')
          ..write('saturday: $saturday, ')
          ..write('sunday: $sunday, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$DailyRecordDBManager extends GeneratedDatabase {
  _$DailyRecordDBManager(QueryExecutor e) : super(e);
  late final DailyRecords dailyRecords = DailyRecords(this);
  late final Habits habits = Habits(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dailyRecords, habits];
}
