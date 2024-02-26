// 文件路径: lib/db/init_medicine_db.dart
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:untitled/db/MedicineDB/medicine_db_manager.dart';
import 'package:drift/drift.dart' as drift;

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
        categoryName: Value(categoryData['categoryName']!),
        icon: Value(categoryData['icon']!),
      ));
    }
  }
  print("药品类别数据插入完成");


  // 药品数据插入逻辑
  final List<Map<String, dynamic>> medicinesData = [{
    'name': '阿苯达唑',
    'mainFunction': '广谱抗虫药，用于驱蛔虫、鞭虫、旋毛虫等',
    'usage': '口服，成人0.4g顿服。2岁以上小儿0.2g顿服。囊虫病每天15～20mg/kg。',
    'description': '本品为高效广谱驱虫新药，对线虫、血吸虫、绦虫均有高度活性。',
    'precautions': '2岁以下小儿及孕妇禁用。',
    'sideEffects': '可能引起轻度头痛、恶心、腹泻等，大多自行消失。',
    'storage': '密封保存。',
    'imageUrl': 'assets/medicineDetail/Albendazole.jpg',
    'categoryId':1, // 假定“抗寄生”类别的ID为1
  },
    {
      'name': '康卫宁',
      'mainFunction': '康卫宁能够高度对抗的细菌有革兰氏阳性需氧菌（例如：中间葡萄球菌）、革兰氏阴性需氧菌（例如：大肠杆菌）、革兰氏阴性厌氧菌（例如：梭杆菌属和拟杆菌属）。 康卫宁对以上这类敏感菌群引起的多种宠物皮肤感染有非常好的治疗效果，也适合用于术后防止伤口感染。',
      'usage': '取本品1瓶,用注射用水10ml溶解。 皮下注射:每1kg体重,犬、猫8mg(以头孢维星计,相当于每1kg体重注射0.1ml)。 最多可维持14日。 如果对犬的治疗效果不彻底,可以进行第二次皮下注射,最多不应超过2次。',
      'description': '用于治疗犬由葡萄球菌和链球菌敏感菌株引起的皮肤感染(如继发性浅表脓皮病、脓肿和创伤),由大肠杆菌和/或变形杆菌引起的尿道感染;治疗猫由多杀性巴氏杆菌和葡萄球菌敏感菌株引起的皮肤感染(如创伤和脓肿),由大肠杆菌引起的尿道感染。',
      'precautions': '己知对β-内酰胺类药物过敏的犬、猫禁用。 如发生过敏性反应,应根据临床表现,采取注射肾上腺素和其他应急措施,包括输氧、静脉输液、静注抗组胺药、皮质类激素以及气道管理。',
      'sideEffects': '个别犬或猫在给药后可能出现过敏反应、昏睡、食欲不振、呕吐和腹泻。',
      'storage': '在2-8℃条件下遮光保存。',
      'imageUrl': 'assets/medicineDetail/Convenia.png',
      'categoryId':2, // 假定“抗寄生”类别的ID为1
    },
  ];
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



