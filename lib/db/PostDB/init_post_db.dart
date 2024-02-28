// 文件路径: lib/db/PostDB/init_post_db.dart
import 'package:flutter/material.dart';
import 'package:untitled/db/PostDB/post_db_manager.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
Future<void> initializePostDatabase() async {
  final db = PostDBManager();

  // 分类数据初始化
  final categories = [
    '热点', '狗狗饲养基础', '狗狗健康与护理', '狗狗行为训练','狗狗救助与领养','营养与饮食','宠物美容与梳理','宠物繁殖与护理','宠物行为与心理','宠物法律与权益'
  ];

  for (var categoryName in categories) {
    final existingCategory = await db.getCategoryByName(categoryName as String);
    if (existingCategory == null) {
      await db.addCategory(CategoriesCompanion(name: drift.Value(categoryName as String)));
    }
  }
  print("类别数据插入完成");
  // 读取JSON文件
  final String postsJson = await rootBundle.loadString('assets/jsons/post.json');
  // 解析JSON内容
  final List<dynamic> postsData = json.decode(postsJson) as List<dynamic>;

  for (var post in postsData) {
    final existingPost = await db.getPostByTitle(post['title'] as String);
    if (existingPost == null) {
      await db.addPost(PostsCompanion(
        title: drift.Value(post['title'] as String), // 明确转换为String
        author: drift.Value(post['author'] as String), // 明确转换为String
        tag: drift.Value(post['tag'] as String?), // 明确转换为String?，因为tag可能是null
        categoryId: drift.Value(post['categoryId'] as int), // 明确转换为int
        date: drift.Value(post['date'] as String), // 明确转换为String
        imagePath: drift.Value(post['imagePath'] as String), // 明确转换为String
        content: drift.Value(post['content'] as String), // 明确转换为String
      ));
    }
  }
  print("帖子数据插入完成");

}



