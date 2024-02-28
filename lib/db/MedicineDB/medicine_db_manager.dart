import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'medicine_db_manager.g.dart'; // Drift 会生成这个文件

@DriftDatabase(
  include: {'MedicineTable.drift'}, // 引入表文件
)
class MedicineDBManager extends _$MedicineDBManager {
  MedicineDBManager._privateConstructor(): super(_openConnection());
  static final MedicineDBManager _instance = MedicineDBManager._privateConstructor();

  factory MedicineDBManager() {
    return _instance;
  }

  @override
  int get schemaVersion => 1;

  Future<int> addMedicineCategory(MedicineCategoriesCompanion category) async {
    return await into(medicineCategories).insert(category);
  }

  Future<int> deleteMedicineCategory(int id) async {
    return await (delete(medicineCategories)..where((t) => t.categoryID.equals(id))).go();
  }

  Future<bool> updateMedicineCategory(MedicineCategoriesCompanion category) async {
    return await update(medicineCategories).replace(category);
  }

  Future<MedicineCategory?> getMedicineCategoryByName(String name) async {
    final query = select(medicineCategories)..where((t) => t.categoryName.equals(name));
    return await query.getSingleOrNull();
  }

  Future<MedicineCategory?> getMedicineCategoryById(int categoryId) async {
    final query = (select(medicineCategories)..where((t) => t.categoryID.equals(categoryId)));
    return await query.getSingleOrNull();
  }

  Future<Medicine?> getMedicineDetailsByName(String name) async {
    return (select(medicines)..where((m) => m.name.equals(name))).getSingleOrNull();
  }

  Future<List<MedicineCategory>> getAllMedicineCategories() async {
    return await select(medicineCategories).get();
  }

  Future<int> addMedicine(MedicinesCompanion medicine) async {
    return await into(medicines).insert(medicine);
  }

  Future<int> deleteMedicine(int id) async {
    return await (delete(medicines)..where((t) => t.medicineID.equals(id))).go();
  }

  Future<bool> updateMedicine(MedicinesCompanion medicine) async {
    return await update(medicines).replace(medicine);
  }

  Future<List<Medicine>> getMedicinesByCategory(int categoryId) async {
    return await (select(medicines)..where((t) => t.categoryID.equals(categoryId))).get();
  }

  Future<Medicine?> getMedicineDetails(int medicineId) async {
    return await (select(medicines)..where((t) => t.medicineID.equals(medicineId))).getSingleOrNull();
  }

  // 搜索药品
  Future<List<Medicine>> searchMedicinesByName(String query) async {
    // 使用 Drift 的查询构建器来构建 LIKE 查询
    final expression = medicines.name.like('%$query%');
    final queryBuilder = select(medicines)..where((_) => expression);
    return await queryBuilder.get();
  }


  Future<List<Medicine>> getAllMedicines() async {
    return await select(medicines).get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'medicine_library.db')); // 数据库名
    print("数据库文件路径: ${file.path}"); // 打印数据库文件路径
    return NativeDatabase(file);
  });
}
