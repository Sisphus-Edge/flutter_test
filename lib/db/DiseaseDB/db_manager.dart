import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'db_manager.g.dart'; // Drift 会生成这个文件

@DriftDatabase(
  include: {'tables.drift'}, // 引入表文件
)
class DBManager extends _$DBManager {
  DBManager._privateConstructor(): super(_openConnection());
  static final DBManager _instance = DBManager._privateConstructor();

  factory DBManager() {
    return _instance;
  }
  @override
  int get schemaVersion => 1; // 版本号

  // 增加一个部门
  Future<int> addDepartment(DepartmentsCompanion department) async {
    return await into(departments).insert(department);
  }

  // 删除一个部门
  Future<int> deleteDepartment(int id) async {
    return await (delete(departments)..where((d) => d.departmentID.equals(id))).go();
  }

  // 更新一个部门
  Future<bool> updateDepartment(DepartmentsCompanion department) async {
    return await update(departments).replace(department);
  }

  // 获取一个部门
  Future<Department?> getDepartmentByName(String name) async {
    final query = select(departments)..where((tbl) => tbl.departmentName.equals(name));
    return query.getSingleOrNull();
  }

  // 在 DBManager 类中添加
  Future<String> getDepartmentNameById(int departmentId) async {
    final query = select(departments)..where((tbl) => tbl.departmentID.equals(departmentId));
    final department = await query.getSingleOrNull();
    return department?.departmentName ?? '未知科室';
  }

  // 获取所有部门
  Future<List<Department>> getAllDepartments() async {
    return await select(departments).get();
  }

  // 添加一个疾病
  Future<int> addDisease(DiseasesCompanion disease) async {
    return await into(diseases).insert(disease);
  }

  // 删除一个疾病
  Future<int> deleteDisease(int id) async {
    return await (delete(diseases)..where((d) => d.diseaseID.equals(id))).go();
  }

  // 更新一个疾病
  Future<bool> updateDisease(DiseasesCompanion disease) async {
    return await update(diseases).replace(disease);
  }

  // 根据部门ID获取疾病列表
  Future<List<Disease>> fetchDiseasesByDepartment(int departmentId) async {
    final query = select(diseases)..where((d) => d.departmentID.equals(departmentId));
    return query.get();
  }

  // 获取特定疾病的详细信息
  Future<Disease?> getDiseaseDetails(int diseaseId) async {
    final query = select(diseases)..where((d) => d.diseaseID.equals(diseaseId));
    return query.getSingleOrNull();
  }


  // 获取所有疾病
  Future<List<Disease>> getAllDiseases() async {
    return await select(diseases).get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'disease_library.db')); // 数据库名
    print("数据库文件路径: ${file.path}"); // 打印数据库文件路径
    return NativeDatabase(file);
  });
}

