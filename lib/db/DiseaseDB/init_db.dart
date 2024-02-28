// 文件路径: lib/db/init_db.dart
import 'package:flutter/material.dart';
import 'package:untitled/db/DiseaseDB/db_manager.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
Future<void> initializeDatabase() async {
  final db = DBManager();

  // 部门数据
  final departments = [
    '内科', '外科', '肿瘤科', '皮肤科', '眼科', '神经科'
  ];


  // 检查并插入部门数据
  for (var deptName in departments) {
    final existingDepartment = await db.getDepartmentByName(deptName);
    if (existingDepartment == null) {
      await db.addDepartment(DepartmentsCompanion.insert(departmentName: deptName));
    }
  }


  print("部门数据插入完成");

  // 读取JSON文件
  final String diseasesJson = await rootBundle.loadString('assets/jsons/disease.json');
  // 解析JSON内容
  final List<dynamic> diseasesData = json.decode(diseasesJson) as List<dynamic>;

  // 插入疾病数据，包括所有新增字段
  for (var disease in diseasesData) {
    final department = await db.getDepartmentByName(disease['departmentName'] as String);
    if (department != null) {
      await db.addDisease(DiseasesCompanion(
        diseaseName: drift.Value(disease['name']!),
        departmentID: drift.Value(department.departmentID),
        description: drift.Value(disease['description']),
        imageUrl: drift.Value(disease['imageUrl']),
        symptoms: drift.Value(disease['symptoms']),
        cause: drift.Value(disease['cause']),
        treatment: drift.Value(disease['treatment']),
        prevention: drift.Value(disease['prevention']),
        diagnosis: drift.Value(disease['diagnosis']),
        care: drift.Value(disease['care']),
      ));
    }
  }

  print("疾病数据插入完成");
}
