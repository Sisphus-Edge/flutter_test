// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_db_manager.dart';

// ignore_for_file: type=lint
class MedicineCategories extends Table
    with TableInfo<MedicineCategories, MedicineCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  MedicineCategories(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _categoryIDMeta =
      const VerificationMeta('categoryID');
  late final GeneratedColumn<int> categoryID = GeneratedColumn<int>(
      'CategoryID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _categoryNameMeta =
      const VerificationMeta('categoryName');
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
      'CategoryName', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'Icon', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [categoryID, categoryName, icon];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'MedicineCategories';
  @override
  VerificationContext validateIntegrity(Insertable<MedicineCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('CategoryID')) {
      context.handle(
          _categoryIDMeta,
          categoryID.isAcceptableOrUnknown(
              data['CategoryID']!, _categoryIDMeta));
    }
    if (data.containsKey('CategoryName')) {
      context.handle(
          _categoryNameMeta,
          categoryName.isAcceptableOrUnknown(
              data['CategoryName']!, _categoryNameMeta));
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
    }
    if (data.containsKey('Icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['Icon']!, _iconMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {categoryID};
  @override
  MedicineCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicineCategory(
      categoryID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}CategoryID'])!,
      categoryName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}CategoryName'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Icon']),
    );
  }

  @override
  MedicineCategories createAlias(String alias) {
    return MedicineCategories(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class MedicineCategory extends DataClass
    implements Insertable<MedicineCategory> {
  final int categoryID;
  final String categoryName;
  final String? icon;
  const MedicineCategory(
      {required this.categoryID, required this.categoryName, this.icon});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['CategoryID'] = Variable<int>(categoryID);
    map['CategoryName'] = Variable<String>(categoryName);
    if (!nullToAbsent || icon != null) {
      map['Icon'] = Variable<String>(icon);
    }
    return map;
  }

  MedicineCategoriesCompanion toCompanion(bool nullToAbsent) {
    return MedicineCategoriesCompanion(
      categoryID: Value(categoryID),
      categoryName: Value(categoryName),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
    );
  }

  factory MedicineCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicineCategory(
      categoryID: serializer.fromJson<int>(json['CategoryID']),
      categoryName: serializer.fromJson<String>(json['CategoryName']),
      icon: serializer.fromJson<String?>(json['Icon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'CategoryID': serializer.toJson<int>(categoryID),
      'CategoryName': serializer.toJson<String>(categoryName),
      'Icon': serializer.toJson<String?>(icon),
    };
  }

  MedicineCategory copyWith(
          {int? categoryID,
          String? categoryName,
          Value<String?> icon = const Value.absent()}) =>
      MedicineCategory(
        categoryID: categoryID ?? this.categoryID,
        categoryName: categoryName ?? this.categoryName,
        icon: icon.present ? icon.value : this.icon,
      );
  @override
  String toString() {
    return (StringBuffer('MedicineCategory(')
          ..write('categoryID: $categoryID, ')
          ..write('categoryName: $categoryName, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(categoryID, categoryName, icon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicineCategory &&
          other.categoryID == this.categoryID &&
          other.categoryName == this.categoryName &&
          other.icon == this.icon);
}

class MedicineCategoriesCompanion extends UpdateCompanion<MedicineCategory> {
  final Value<int> categoryID;
  final Value<String> categoryName;
  final Value<String?> icon;
  const MedicineCategoriesCompanion({
    this.categoryID = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.icon = const Value.absent(),
  });
  MedicineCategoriesCompanion.insert({
    this.categoryID = const Value.absent(),
    required String categoryName,
    this.icon = const Value.absent(),
  }) : categoryName = Value(categoryName);
  static Insertable<MedicineCategory> custom({
    Expression<int>? categoryID,
    Expression<String>? categoryName,
    Expression<String>? icon,
  }) {
    return RawValuesInsertable({
      if (categoryID != null) 'CategoryID': categoryID,
      if (categoryName != null) 'CategoryName': categoryName,
      if (icon != null) 'Icon': icon,
    });
  }

  MedicineCategoriesCompanion copyWith(
      {Value<int>? categoryID,
      Value<String>? categoryName,
      Value<String?>? icon}) {
    return MedicineCategoriesCompanion(
      categoryID: categoryID ?? this.categoryID,
      categoryName: categoryName ?? this.categoryName,
      icon: icon ?? this.icon,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (categoryID.present) {
      map['CategoryID'] = Variable<int>(categoryID.value);
    }
    if (categoryName.present) {
      map['CategoryName'] = Variable<String>(categoryName.value);
    }
    if (icon.present) {
      map['Icon'] = Variable<String>(icon.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicineCategoriesCompanion(')
          ..write('categoryID: $categoryID, ')
          ..write('categoryName: $categoryName, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }
}

class Medicines extends Table with TableInfo<Medicines, Medicine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Medicines(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _medicineIDMeta =
      const VerificationMeta('medicineID');
  late final GeneratedColumn<int> medicineID = GeneratedColumn<int>(
      'MedicineID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'Name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _mainFunctionMeta =
      const VerificationMeta('mainFunction');
  late final GeneratedColumn<String> mainFunction = GeneratedColumn<String>(
      'MainFunction', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _usageMeta = const VerificationMeta('usage');
  late final GeneratedColumn<String> usage = GeneratedColumn<String>(
      'Usage', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'Description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _precautionsMeta =
      const VerificationMeta('precautions');
  late final GeneratedColumn<String> precautions = GeneratedColumn<String>(
      'Precautions', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _sideEffectsMeta =
      const VerificationMeta('sideEffects');
  late final GeneratedColumn<String> sideEffects = GeneratedColumn<String>(
      'SideEffects', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _storageMeta =
      const VerificationMeta('storage');
  late final GeneratedColumn<String> storage = GeneratedColumn<String>(
      'Storage', aliasedName, true,
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
  static const VerificationMeta _categoryIDMeta =
      const VerificationMeta('categoryID');
  late final GeneratedColumn<int> categoryID = GeneratedColumn<int>(
      'CategoryID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        medicineID,
        name,
        mainFunction,
        usage,
        description,
        precautions,
        sideEffects,
        storage,
        imageUrl,
        categoryID
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Medicines';
  @override
  VerificationContext validateIntegrity(Insertable<Medicine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('MedicineID')) {
      context.handle(
          _medicineIDMeta,
          medicineID.isAcceptableOrUnknown(
              data['MedicineID']!, _medicineIDMeta));
    }
    if (data.containsKey('Name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['Name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('MainFunction')) {
      context.handle(
          _mainFunctionMeta,
          mainFunction.isAcceptableOrUnknown(
              data['MainFunction']!, _mainFunctionMeta));
    } else if (isInserting) {
      context.missing(_mainFunctionMeta);
    }
    if (data.containsKey('Usage')) {
      context.handle(
          _usageMeta, usage.isAcceptableOrUnknown(data['Usage']!, _usageMeta));
    } else if (isInserting) {
      context.missing(_usageMeta);
    }
    if (data.containsKey('Description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['Description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('Precautions')) {
      context.handle(
          _precautionsMeta,
          precautions.isAcceptableOrUnknown(
              data['Precautions']!, _precautionsMeta));
    }
    if (data.containsKey('SideEffects')) {
      context.handle(
          _sideEffectsMeta,
          sideEffects.isAcceptableOrUnknown(
              data['SideEffects']!, _sideEffectsMeta));
    }
    if (data.containsKey('Storage')) {
      context.handle(_storageMeta,
          storage.isAcceptableOrUnknown(data['Storage']!, _storageMeta));
    }
    if (data.containsKey('ImageUrl')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['ImageUrl']!, _imageUrlMeta));
    }
    if (data.containsKey('CategoryID')) {
      context.handle(
          _categoryIDMeta,
          categoryID.isAcceptableOrUnknown(
              data['CategoryID']!, _categoryIDMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {medicineID};
  @override
  Medicine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Medicine(
      medicineID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}MedicineID'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Name'])!,
      mainFunction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}MainFunction'])!,
      usage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Usage'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Description'])!,
      precautions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Precautions']),
      sideEffects: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}SideEffects']),
      storage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Storage']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ImageUrl']),
      categoryID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}CategoryID']),
    );
  }

  @override
  Medicines createAlias(String alias) {
    return Medicines(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(CategoryID)REFERENCES MedicineCategories(CategoryID)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class Medicine extends DataClass implements Insertable<Medicine> {
  final int medicineID;
  final String name;
  final String mainFunction;
  final String usage;
  final String description;
  final String? precautions;
  final String? sideEffects;
  final String? storage;
  final String? imageUrl;
  final int? categoryID;
  const Medicine(
      {required this.medicineID,
      required this.name,
      required this.mainFunction,
      required this.usage,
      required this.description,
      this.precautions,
      this.sideEffects,
      this.storage,
      this.imageUrl,
      this.categoryID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['MedicineID'] = Variable<int>(medicineID);
    map['Name'] = Variable<String>(name);
    map['MainFunction'] = Variable<String>(mainFunction);
    map['Usage'] = Variable<String>(usage);
    map['Description'] = Variable<String>(description);
    if (!nullToAbsent || precautions != null) {
      map['Precautions'] = Variable<String>(precautions);
    }
    if (!nullToAbsent || sideEffects != null) {
      map['SideEffects'] = Variable<String>(sideEffects);
    }
    if (!nullToAbsent || storage != null) {
      map['Storage'] = Variable<String>(storage);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['ImageUrl'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || categoryID != null) {
      map['CategoryID'] = Variable<int>(categoryID);
    }
    return map;
  }

  MedicinesCompanion toCompanion(bool nullToAbsent) {
    return MedicinesCompanion(
      medicineID: Value(medicineID),
      name: Value(name),
      mainFunction: Value(mainFunction),
      usage: Value(usage),
      description: Value(description),
      precautions: precautions == null && nullToAbsent
          ? const Value.absent()
          : Value(precautions),
      sideEffects: sideEffects == null && nullToAbsent
          ? const Value.absent()
          : Value(sideEffects),
      storage: storage == null && nullToAbsent
          ? const Value.absent()
          : Value(storage),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      categoryID: categoryID == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryID),
    );
  }

  factory Medicine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Medicine(
      medicineID: serializer.fromJson<int>(json['MedicineID']),
      name: serializer.fromJson<String>(json['Name']),
      mainFunction: serializer.fromJson<String>(json['MainFunction']),
      usage: serializer.fromJson<String>(json['Usage']),
      description: serializer.fromJson<String>(json['Description']),
      precautions: serializer.fromJson<String?>(json['Precautions']),
      sideEffects: serializer.fromJson<String?>(json['SideEffects']),
      storage: serializer.fromJson<String?>(json['Storage']),
      imageUrl: serializer.fromJson<String?>(json['ImageUrl']),
      categoryID: serializer.fromJson<int?>(json['CategoryID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'MedicineID': serializer.toJson<int>(medicineID),
      'Name': serializer.toJson<String>(name),
      'MainFunction': serializer.toJson<String>(mainFunction),
      'Usage': serializer.toJson<String>(usage),
      'Description': serializer.toJson<String>(description),
      'Precautions': serializer.toJson<String?>(precautions),
      'SideEffects': serializer.toJson<String?>(sideEffects),
      'Storage': serializer.toJson<String?>(storage),
      'ImageUrl': serializer.toJson<String?>(imageUrl),
      'CategoryID': serializer.toJson<int?>(categoryID),
    };
  }

  Medicine copyWith(
          {int? medicineID,
          String? name,
          String? mainFunction,
          String? usage,
          String? description,
          Value<String?> precautions = const Value.absent(),
          Value<String?> sideEffects = const Value.absent(),
          Value<String?> storage = const Value.absent(),
          Value<String?> imageUrl = const Value.absent(),
          Value<int?> categoryID = const Value.absent()}) =>
      Medicine(
        medicineID: medicineID ?? this.medicineID,
        name: name ?? this.name,
        mainFunction: mainFunction ?? this.mainFunction,
        usage: usage ?? this.usage,
        description: description ?? this.description,
        precautions: precautions.present ? precautions.value : this.precautions,
        sideEffects: sideEffects.present ? sideEffects.value : this.sideEffects,
        storage: storage.present ? storage.value : this.storage,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        categoryID: categoryID.present ? categoryID.value : this.categoryID,
      );
  @override
  String toString() {
    return (StringBuffer('Medicine(')
          ..write('medicineID: $medicineID, ')
          ..write('name: $name, ')
          ..write('mainFunction: $mainFunction, ')
          ..write('usage: $usage, ')
          ..write('description: $description, ')
          ..write('precautions: $precautions, ')
          ..write('sideEffects: $sideEffects, ')
          ..write('storage: $storage, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('categoryID: $categoryID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(medicineID, name, mainFunction, usage,
      description, precautions, sideEffects, storage, imageUrl, categoryID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Medicine &&
          other.medicineID == this.medicineID &&
          other.name == this.name &&
          other.mainFunction == this.mainFunction &&
          other.usage == this.usage &&
          other.description == this.description &&
          other.precautions == this.precautions &&
          other.sideEffects == this.sideEffects &&
          other.storage == this.storage &&
          other.imageUrl == this.imageUrl &&
          other.categoryID == this.categoryID);
}

class MedicinesCompanion extends UpdateCompanion<Medicine> {
  final Value<int> medicineID;
  final Value<String> name;
  final Value<String> mainFunction;
  final Value<String> usage;
  final Value<String> description;
  final Value<String?> precautions;
  final Value<String?> sideEffects;
  final Value<String?> storage;
  final Value<String?> imageUrl;
  final Value<int?> categoryID;
  const MedicinesCompanion({
    this.medicineID = const Value.absent(),
    this.name = const Value.absent(),
    this.mainFunction = const Value.absent(),
    this.usage = const Value.absent(),
    this.description = const Value.absent(),
    this.precautions = const Value.absent(),
    this.sideEffects = const Value.absent(),
    this.storage = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.categoryID = const Value.absent(),
  });
  MedicinesCompanion.insert({
    this.medicineID = const Value.absent(),
    required String name,
    required String mainFunction,
    required String usage,
    required String description,
    this.precautions = const Value.absent(),
    this.sideEffects = const Value.absent(),
    this.storage = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.categoryID = const Value.absent(),
  })  : name = Value(name),
        mainFunction = Value(mainFunction),
        usage = Value(usage),
        description = Value(description);
  static Insertable<Medicine> custom({
    Expression<int>? medicineID,
    Expression<String>? name,
    Expression<String>? mainFunction,
    Expression<String>? usage,
    Expression<String>? description,
    Expression<String>? precautions,
    Expression<String>? sideEffects,
    Expression<String>? storage,
    Expression<String>? imageUrl,
    Expression<int>? categoryID,
  }) {
    return RawValuesInsertable({
      if (medicineID != null) 'MedicineID': medicineID,
      if (name != null) 'Name': name,
      if (mainFunction != null) 'MainFunction': mainFunction,
      if (usage != null) 'Usage': usage,
      if (description != null) 'Description': description,
      if (precautions != null) 'Precautions': precautions,
      if (sideEffects != null) 'SideEffects': sideEffects,
      if (storage != null) 'Storage': storage,
      if (imageUrl != null) 'ImageUrl': imageUrl,
      if (categoryID != null) 'CategoryID': categoryID,
    });
  }

  MedicinesCompanion copyWith(
      {Value<int>? medicineID,
      Value<String>? name,
      Value<String>? mainFunction,
      Value<String>? usage,
      Value<String>? description,
      Value<String?>? precautions,
      Value<String?>? sideEffects,
      Value<String?>? storage,
      Value<String?>? imageUrl,
      Value<int?>? categoryID}) {
    return MedicinesCompanion(
      medicineID: medicineID ?? this.medicineID,
      name: name ?? this.name,
      mainFunction: mainFunction ?? this.mainFunction,
      usage: usage ?? this.usage,
      description: description ?? this.description,
      precautions: precautions ?? this.precautions,
      sideEffects: sideEffects ?? this.sideEffects,
      storage: storage ?? this.storage,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryID: categoryID ?? this.categoryID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (medicineID.present) {
      map['MedicineID'] = Variable<int>(medicineID.value);
    }
    if (name.present) {
      map['Name'] = Variable<String>(name.value);
    }
    if (mainFunction.present) {
      map['MainFunction'] = Variable<String>(mainFunction.value);
    }
    if (usage.present) {
      map['Usage'] = Variable<String>(usage.value);
    }
    if (description.present) {
      map['Description'] = Variable<String>(description.value);
    }
    if (precautions.present) {
      map['Precautions'] = Variable<String>(precautions.value);
    }
    if (sideEffects.present) {
      map['SideEffects'] = Variable<String>(sideEffects.value);
    }
    if (storage.present) {
      map['Storage'] = Variable<String>(storage.value);
    }
    if (imageUrl.present) {
      map['ImageUrl'] = Variable<String>(imageUrl.value);
    }
    if (categoryID.present) {
      map['CategoryID'] = Variable<int>(categoryID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicinesCompanion(')
          ..write('medicineID: $medicineID, ')
          ..write('name: $name, ')
          ..write('mainFunction: $mainFunction, ')
          ..write('usage: $usage, ')
          ..write('description: $description, ')
          ..write('precautions: $precautions, ')
          ..write('sideEffects: $sideEffects, ')
          ..write('storage: $storage, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('categoryID: $categoryID')
          ..write(')'))
        .toString();
  }
}

abstract class _$MedicineDBManager extends GeneratedDatabase {
  _$MedicineDBManager(QueryExecutor e) : super(e);
  late final MedicineCategories medicineCategories = MedicineCategories(this);
  late final Medicines medicines = Medicines(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [medicineCategories, medicines];
}
