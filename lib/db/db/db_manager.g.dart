// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_manager.dart';

// ignore_for_file: type=lint
class Departments extends Table with TableInfo<Departments, Department> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Departments(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _departmentIDMeta =
      const VerificationMeta('departmentID');
  late final GeneratedColumn<int> departmentID = GeneratedColumn<int>(
      'DepartmentID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _departmentNameMeta =
      const VerificationMeta('departmentName');
  late final GeneratedColumn<String> departmentName = GeneratedColumn<String>(
      'DepartmentName', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [departmentID, departmentName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Departments';
  @override
  VerificationContext validateIntegrity(Insertable<Department> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('DepartmentID')) {
      context.handle(
          _departmentIDMeta,
          departmentID.isAcceptableOrUnknown(
              data['DepartmentID']!, _departmentIDMeta));
    }
    if (data.containsKey('DepartmentName')) {
      context.handle(
          _departmentNameMeta,
          departmentName.isAcceptableOrUnknown(
              data['DepartmentName']!, _departmentNameMeta));
    } else if (isInserting) {
      context.missing(_departmentNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {departmentID};
  @override
  Department map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Department(
      departmentID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}DepartmentID'])!,
      departmentName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}DepartmentName'])!,
    );
  }

  @override
  Departments createAlias(String alias) {
    return Departments(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Department extends DataClass implements Insertable<Department> {
  final int departmentID;
  final String departmentName;
  const Department({required this.departmentID, required this.departmentName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['DepartmentID'] = Variable<int>(departmentID);
    map['DepartmentName'] = Variable<String>(departmentName);
    return map;
  }

  DepartmentsCompanion toCompanion(bool nullToAbsent) {
    return DepartmentsCompanion(
      departmentID: Value(departmentID),
      departmentName: Value(departmentName),
    );
  }

  factory Department.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Department(
      departmentID: serializer.fromJson<int>(json['DepartmentID']),
      departmentName: serializer.fromJson<String>(json['DepartmentName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'DepartmentID': serializer.toJson<int>(departmentID),
      'DepartmentName': serializer.toJson<String>(departmentName),
    };
  }

  Department copyWith({int? departmentID, String? departmentName}) =>
      Department(
        departmentID: departmentID ?? this.departmentID,
        departmentName: departmentName ?? this.departmentName,
      );
  @override
  String toString() {
    return (StringBuffer('Department(')
          ..write('departmentID: $departmentID, ')
          ..write('departmentName: $departmentName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(departmentID, departmentName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Department &&
          other.departmentID == this.departmentID &&
          other.departmentName == this.departmentName);
}

class DepartmentsCompanion extends UpdateCompanion<Department> {
  final Value<int> departmentID;
  final Value<String> departmentName;
  const DepartmentsCompanion({
    this.departmentID = const Value.absent(),
    this.departmentName = const Value.absent(),
  });
  DepartmentsCompanion.insert({
    this.departmentID = const Value.absent(),
    required String departmentName,
  }) : departmentName = Value(departmentName);
  static Insertable<Department> custom({
    Expression<int>? departmentID,
    Expression<String>? departmentName,
  }) {
    return RawValuesInsertable({
      if (departmentID != null) 'DepartmentID': departmentID,
      if (departmentName != null) 'DepartmentName': departmentName,
    });
  }

  DepartmentsCompanion copyWith(
      {Value<int>? departmentID, Value<String>? departmentName}) {
    return DepartmentsCompanion(
      departmentID: departmentID ?? this.departmentID,
      departmentName: departmentName ?? this.departmentName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (departmentID.present) {
      map['DepartmentID'] = Variable<int>(departmentID.value);
    }
    if (departmentName.present) {
      map['DepartmentName'] = Variable<String>(departmentName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DepartmentsCompanion(')
          ..write('departmentID: $departmentID, ')
          ..write('departmentName: $departmentName')
          ..write(')'))
        .toString();
  }
}

class Diseases extends Table with TableInfo<Diseases, Disease> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Diseases(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _diseaseIDMeta =
      const VerificationMeta('diseaseID');
  late final GeneratedColumn<int> diseaseID = GeneratedColumn<int>(
      'DiseaseID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _diseaseNameMeta =
      const VerificationMeta('diseaseName');
  late final GeneratedColumn<String> diseaseName = GeneratedColumn<String>(
      'DiseaseName', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _departmentIDMeta =
      const VerificationMeta('departmentID');
  late final GeneratedColumn<int> departmentID = GeneratedColumn<int>(
      'DepartmentID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'Description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _symptomsMeta =
      const VerificationMeta('symptoms');
  late final GeneratedColumn<String> symptoms = GeneratedColumn<String>(
      'Symptoms', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _causeMeta = const VerificationMeta('cause');
  late final GeneratedColumn<String> cause = GeneratedColumn<String>(
      'Cause', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _treatmentMeta =
      const VerificationMeta('treatment');
  late final GeneratedColumn<String> treatment = GeneratedColumn<String>(
      'Treatment', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _preventionMeta =
      const VerificationMeta('prevention');
  late final GeneratedColumn<String> prevention = GeneratedColumn<String>(
      'Prevention', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _diagnosisMeta =
      const VerificationMeta('diagnosis');
  late final GeneratedColumn<String> diagnosis = GeneratedColumn<String>(
      'Diagnosis', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _careMeta = const VerificationMeta('care');
  late final GeneratedColumn<String> care = GeneratedColumn<String>(
      'Care', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'ImageUrl', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        diseaseID,
        diseaseName,
        departmentID,
        description,
        symptoms,
        cause,
        treatment,
        prevention,
        diagnosis,
        care,
        imageUrl
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Diseases';
  @override
  VerificationContext validateIntegrity(Insertable<Disease> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('DiseaseID')) {
      context.handle(_diseaseIDMeta,
          diseaseID.isAcceptableOrUnknown(data['DiseaseID']!, _diseaseIDMeta));
    }
    if (data.containsKey('DiseaseName')) {
      context.handle(
          _diseaseNameMeta,
          diseaseName.isAcceptableOrUnknown(
              data['DiseaseName']!, _diseaseNameMeta));
    } else if (isInserting) {
      context.missing(_diseaseNameMeta);
    }
    if (data.containsKey('DepartmentID')) {
      context.handle(
          _departmentIDMeta,
          departmentID.isAcceptableOrUnknown(
              data['DepartmentID']!, _departmentIDMeta));
    }
    if (data.containsKey('Description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['Description']!, _descriptionMeta));
    }
    if (data.containsKey('Symptoms')) {
      context.handle(_symptomsMeta,
          symptoms.isAcceptableOrUnknown(data['Symptoms']!, _symptomsMeta));
    }
    if (data.containsKey('Cause')) {
      context.handle(
          _causeMeta, cause.isAcceptableOrUnknown(data['Cause']!, _causeMeta));
    }
    if (data.containsKey('Treatment')) {
      context.handle(_treatmentMeta,
          treatment.isAcceptableOrUnknown(data['Treatment']!, _treatmentMeta));
    }
    if (data.containsKey('Prevention')) {
      context.handle(
          _preventionMeta,
          prevention.isAcceptableOrUnknown(
              data['Prevention']!, _preventionMeta));
    }
    if (data.containsKey('Diagnosis')) {
      context.handle(_diagnosisMeta,
          diagnosis.isAcceptableOrUnknown(data['Diagnosis']!, _diagnosisMeta));
    }
    if (data.containsKey('Care')) {
      context.handle(
          _careMeta, care.isAcceptableOrUnknown(data['Care']!, _careMeta));
    }
    if (data.containsKey('ImageUrl')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['ImageUrl']!, _imageUrlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {diseaseID};
  @override
  Disease map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Disease(
      diseaseID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}DiseaseID'])!,
      diseaseName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}DiseaseName'])!,
      departmentID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}DepartmentID']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Description']),
      symptoms: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Symptoms']),
      cause: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Cause']),
      treatment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Treatment']),
      prevention: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Prevention']),
      diagnosis: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Diagnosis']),
      care: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Care']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ImageUrl']),
    );
  }

  @override
  Diseases createAlias(String alias) {
    return Diseases(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(DepartmentID)REFERENCES Departments(DepartmentID)'];
  @override
  bool get dontWriteConstraints => true;
}

class Disease extends DataClass implements Insertable<Disease> {
  final int diseaseID;
  final String diseaseName;
  final int? departmentID;
  final String? description;
  final String? symptoms;
  final String? cause;
  final String? treatment;
  final String? prevention;
  final String? diagnosis;
  final String? care;
  final String? imageUrl;
  const Disease(
      {required this.diseaseID,
      required this.diseaseName,
      this.departmentID,
      this.description,
      this.symptoms,
      this.cause,
      this.treatment,
      this.prevention,
      this.diagnosis,
      this.care,
      this.imageUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['DiseaseID'] = Variable<int>(diseaseID);
    map['DiseaseName'] = Variable<String>(diseaseName);
    if (!nullToAbsent || departmentID != null) {
      map['DepartmentID'] = Variable<int>(departmentID);
    }
    if (!nullToAbsent || description != null) {
      map['Description'] = Variable<String>(description);
    }
    if (!nullToAbsent || symptoms != null) {
      map['Symptoms'] = Variable<String>(symptoms);
    }
    if (!nullToAbsent || cause != null) {
      map['Cause'] = Variable<String>(cause);
    }
    if (!nullToAbsent || treatment != null) {
      map['Treatment'] = Variable<String>(treatment);
    }
    if (!nullToAbsent || prevention != null) {
      map['Prevention'] = Variable<String>(prevention);
    }
    if (!nullToAbsent || diagnosis != null) {
      map['Diagnosis'] = Variable<String>(diagnosis);
    }
    if (!nullToAbsent || care != null) {
      map['Care'] = Variable<String>(care);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['ImageUrl'] = Variable<String>(imageUrl);
    }
    return map;
  }

  DiseasesCompanion toCompanion(bool nullToAbsent) {
    return DiseasesCompanion(
      diseaseID: Value(diseaseID),
      diseaseName: Value(diseaseName),
      departmentID: departmentID == null && nullToAbsent
          ? const Value.absent()
          : Value(departmentID),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      symptoms: symptoms == null && nullToAbsent
          ? const Value.absent()
          : Value(symptoms),
      cause:
          cause == null && nullToAbsent ? const Value.absent() : Value(cause),
      treatment: treatment == null && nullToAbsent
          ? const Value.absent()
          : Value(treatment),
      prevention: prevention == null && nullToAbsent
          ? const Value.absent()
          : Value(prevention),
      diagnosis: diagnosis == null && nullToAbsent
          ? const Value.absent()
          : Value(diagnosis),
      care: care == null && nullToAbsent ? const Value.absent() : Value(care),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
    );
  }

  factory Disease.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Disease(
      diseaseID: serializer.fromJson<int>(json['DiseaseID']),
      diseaseName: serializer.fromJson<String>(json['DiseaseName']),
      departmentID: serializer.fromJson<int?>(json['DepartmentID']),
      description: serializer.fromJson<String?>(json['Description']),
      symptoms: serializer.fromJson<String?>(json['Symptoms']),
      cause: serializer.fromJson<String?>(json['Cause']),
      treatment: serializer.fromJson<String?>(json['Treatment']),
      prevention: serializer.fromJson<String?>(json['Prevention']),
      diagnosis: serializer.fromJson<String?>(json['Diagnosis']),
      care: serializer.fromJson<String?>(json['Care']),
      imageUrl: serializer.fromJson<String?>(json['ImageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'DiseaseID': serializer.toJson<int>(diseaseID),
      'DiseaseName': serializer.toJson<String>(diseaseName),
      'DepartmentID': serializer.toJson<int?>(departmentID),
      'Description': serializer.toJson<String?>(description),
      'Symptoms': serializer.toJson<String?>(symptoms),
      'Cause': serializer.toJson<String?>(cause),
      'Treatment': serializer.toJson<String?>(treatment),
      'Prevention': serializer.toJson<String?>(prevention),
      'Diagnosis': serializer.toJson<String?>(diagnosis),
      'Care': serializer.toJson<String?>(care),
      'ImageUrl': serializer.toJson<String?>(imageUrl),
    };
  }

  Disease copyWith(
          {int? diseaseID,
          String? diseaseName,
          Value<int?> departmentID = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> symptoms = const Value.absent(),
          Value<String?> cause = const Value.absent(),
          Value<String?> treatment = const Value.absent(),
          Value<String?> prevention = const Value.absent(),
          Value<String?> diagnosis = const Value.absent(),
          Value<String?> care = const Value.absent(),
          Value<String?> imageUrl = const Value.absent()}) =>
      Disease(
        diseaseID: diseaseID ?? this.diseaseID,
        diseaseName: diseaseName ?? this.diseaseName,
        departmentID:
            departmentID.present ? departmentID.value : this.departmentID,
        description: description.present ? description.value : this.description,
        symptoms: symptoms.present ? symptoms.value : this.symptoms,
        cause: cause.present ? cause.value : this.cause,
        treatment: treatment.present ? treatment.value : this.treatment,
        prevention: prevention.present ? prevention.value : this.prevention,
        diagnosis: diagnosis.present ? diagnosis.value : this.diagnosis,
        care: care.present ? care.value : this.care,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
      );
  @override
  String toString() {
    return (StringBuffer('Disease(')
          ..write('diseaseID: $diseaseID, ')
          ..write('diseaseName: $diseaseName, ')
          ..write('departmentID: $departmentID, ')
          ..write('description: $description, ')
          ..write('symptoms: $symptoms, ')
          ..write('cause: $cause, ')
          ..write('treatment: $treatment, ')
          ..write('prevention: $prevention, ')
          ..write('diagnosis: $diagnosis, ')
          ..write('care: $care, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      diseaseID,
      diseaseName,
      departmentID,
      description,
      symptoms,
      cause,
      treatment,
      prevention,
      diagnosis,
      care,
      imageUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Disease &&
          other.diseaseID == this.diseaseID &&
          other.diseaseName == this.diseaseName &&
          other.departmentID == this.departmentID &&
          other.description == this.description &&
          other.symptoms == this.symptoms &&
          other.cause == this.cause &&
          other.treatment == this.treatment &&
          other.prevention == this.prevention &&
          other.diagnosis == this.diagnosis &&
          other.care == this.care &&
          other.imageUrl == this.imageUrl);
}

class DiseasesCompanion extends UpdateCompanion<Disease> {
  final Value<int> diseaseID;
  final Value<String> diseaseName;
  final Value<int?> departmentID;
  final Value<String?> description;
  final Value<String?> symptoms;
  final Value<String?> cause;
  final Value<String?> treatment;
  final Value<String?> prevention;
  final Value<String?> diagnosis;
  final Value<String?> care;
  final Value<String?> imageUrl;
  const DiseasesCompanion({
    this.diseaseID = const Value.absent(),
    this.diseaseName = const Value.absent(),
    this.departmentID = const Value.absent(),
    this.description = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.cause = const Value.absent(),
    this.treatment = const Value.absent(),
    this.prevention = const Value.absent(),
    this.diagnosis = const Value.absent(),
    this.care = const Value.absent(),
    this.imageUrl = const Value.absent(),
  });
  DiseasesCompanion.insert({
    this.diseaseID = const Value.absent(),
    required String diseaseName,
    this.departmentID = const Value.absent(),
    this.description = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.cause = const Value.absent(),
    this.treatment = const Value.absent(),
    this.prevention = const Value.absent(),
    this.diagnosis = const Value.absent(),
    this.care = const Value.absent(),
    this.imageUrl = const Value.absent(),
  }) : diseaseName = Value(diseaseName);
  static Insertable<Disease> custom({
    Expression<int>? diseaseID,
    Expression<String>? diseaseName,
    Expression<int>? departmentID,
    Expression<String>? description,
    Expression<String>? symptoms,
    Expression<String>? cause,
    Expression<String>? treatment,
    Expression<String>? prevention,
    Expression<String>? diagnosis,
    Expression<String>? care,
    Expression<String>? imageUrl,
  }) {
    return RawValuesInsertable({
      if (diseaseID != null) 'DiseaseID': diseaseID,
      if (diseaseName != null) 'DiseaseName': diseaseName,
      if (departmentID != null) 'DepartmentID': departmentID,
      if (description != null) 'Description': description,
      if (symptoms != null) 'Symptoms': symptoms,
      if (cause != null) 'Cause': cause,
      if (treatment != null) 'Treatment': treatment,
      if (prevention != null) 'Prevention': prevention,
      if (diagnosis != null) 'Diagnosis': diagnosis,
      if (care != null) 'Care': care,
      if (imageUrl != null) 'ImageUrl': imageUrl,
    });
  }

  DiseasesCompanion copyWith(
      {Value<int>? diseaseID,
      Value<String>? diseaseName,
      Value<int?>? departmentID,
      Value<String?>? description,
      Value<String?>? symptoms,
      Value<String?>? cause,
      Value<String?>? treatment,
      Value<String?>? prevention,
      Value<String?>? diagnosis,
      Value<String?>? care,
      Value<String?>? imageUrl}) {
    return DiseasesCompanion(
      diseaseID: diseaseID ?? this.diseaseID,
      diseaseName: diseaseName ?? this.diseaseName,
      departmentID: departmentID ?? this.departmentID,
      description: description ?? this.description,
      symptoms: symptoms ?? this.symptoms,
      cause: cause ?? this.cause,
      treatment: treatment ?? this.treatment,
      prevention: prevention ?? this.prevention,
      diagnosis: diagnosis ?? this.diagnosis,
      care: care ?? this.care,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (diseaseID.present) {
      map['DiseaseID'] = Variable<int>(diseaseID.value);
    }
    if (diseaseName.present) {
      map['DiseaseName'] = Variable<String>(diseaseName.value);
    }
    if (departmentID.present) {
      map['DepartmentID'] = Variable<int>(departmentID.value);
    }
    if (description.present) {
      map['Description'] = Variable<String>(description.value);
    }
    if (symptoms.present) {
      map['Symptoms'] = Variable<String>(symptoms.value);
    }
    if (cause.present) {
      map['Cause'] = Variable<String>(cause.value);
    }
    if (treatment.present) {
      map['Treatment'] = Variable<String>(treatment.value);
    }
    if (prevention.present) {
      map['Prevention'] = Variable<String>(prevention.value);
    }
    if (diagnosis.present) {
      map['Diagnosis'] = Variable<String>(diagnosis.value);
    }
    if (care.present) {
      map['Care'] = Variable<String>(care.value);
    }
    if (imageUrl.present) {
      map['ImageUrl'] = Variable<String>(imageUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiseasesCompanion(')
          ..write('diseaseID: $diseaseID, ')
          ..write('diseaseName: $diseaseName, ')
          ..write('departmentID: $departmentID, ')
          ..write('description: $description, ')
          ..write('symptoms: $symptoms, ')
          ..write('cause: $cause, ')
          ..write('treatment: $treatment, ')
          ..write('prevention: $prevention, ')
          ..write('diagnosis: $diagnosis, ')
          ..write('care: $care, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }
}

abstract class _$DBManager extends GeneratedDatabase {
  _$DBManager(QueryExecutor e) : super(e);
  late final Departments departments = Departments(this);
  late final Diseases diseases = Diseases(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [departments, diseases];
}
