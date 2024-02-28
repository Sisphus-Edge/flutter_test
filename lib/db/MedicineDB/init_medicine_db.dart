// 文件路径: lib/db/init_medicine_db.dart
import 'package:flutter/material.dart';
import 'package:untitled/db/MedicineDB/medicine_db_manager.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<void> initializeMedicineDatabase() async {
  final db = MedicineDBManager();

  // 药品类别数据
  final categoriesData = [
    {'categoryName': '抗寄生', 'icon': 'bug_report'},
    {'categoryName': '皮肤病', 'icon': 'healing'},
    {'categoryName': '消化', 'icon': 'restaurant'},
    {'categoryName': '呼吸', 'icon': 'air'},
    {'categoryName': '心血管', 'icon': 'favorite'},
    {'categoryName': '行为', 'icon': 'psychology'},
    {'categoryName': '关节', 'icon': 'fitness_center'},
    {'categoryName': '眼耳', 'icon': 'visibility'},
    {'categoryName': '疫苗', 'icon': 'local_hospital'},
    {'categoryName': '补充剂', 'icon': 'spa'},
  ];

  // 检查并插入药品类别数据
  for (var categoryData in categoriesData) {
    final existingCategory = await db.getMedicineCategoryByName(categoryData['categoryName']!);
    if (existingCategory == null) {
      await db.addMedicineCategory(MedicineCategoriesCompanion(
        categoryName:drift.Value(categoryData['categoryName']!),
        icon: drift.Value(categoryData['icon']!),
      ));
    }
  }
  print("药品类别数据插入完成");


  // 读取JSON文件
  final String medicinesJson = await rootBundle.loadString('assets/jsons/medicine.json');
  // 解析JSON内容
  final List<dynamic> medicinesData = json.decode(medicinesJson) as List<dynamic>;


  // 检查并插入药品数据
  for (var medicineData in medicinesData) {
    final category = await db.getMedicineCategoryById(medicineData['categoryId'] as int);
    if (category != null) {
      final existingMedicine = await db.getMedicineDetailsByName(medicineData['name'] as String);
      if (existingMedicine == null) {
        await db.addMedicine(MedicinesCompanion(
          name: drift.Value(medicineData['name'] as String),
          mainFunction: drift.Value(medicineData['mainFunction'] as String),
          usage: drift.Value(medicineData['usage'] as String),
          description: drift.Value(medicineData['description'] as String),
          precautions: drift.Value(medicineData['precautions'] as String),
          sideEffects: drift.Value(medicineData['sideEffects'] as String),
          storage: drift.Value(medicineData['storage'] as String),
          imageUrl: drift.Value(medicineData['imageUrl'] as String),
          categoryID: drift.Value(medicineData['categoryId'] as int),
        ));
      }
    }
  }
  print("药品数据插入完成");

}



