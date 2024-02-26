// 文件路径: lib/db/PostDB/init_post_db.dart
import 'package:flutter/material.dart';
import 'package:untitled/db/PostDB/post_db_manager.dart';
import 'package:drift/drift.dart' as drift;

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

  // 帖子数据初始化
  final posts = [{
    'title':'幼犬的初期饲养',
    'author':'宠物百科全书',
    'tag': '驯养建议',
    'categoryId': 2, // 假设"宠物饲养基础"的ID是2
    'date':'2020-11-22',
    'imagePath': 'assets/postDetail/post1.jpg',
    'content': '刚买来的幼犬年龄基本在2-3个月左右，这个时间的狗狗刚刚开始认识这个世界，需要主人细心的教导和照顾。'
    },
    {
      'title':'驯养小建议',
      'author':'宠物百科全书',
      'tag': '驯养建议',
      'categoryId': 2, // 假设"宠物饲养基础"的ID是2
      'date':'2020-11-25',
      'imagePath': 'assets/postDetail/post2.png',
      'content': '3个月以后的狗狗发育基本成型，性格也开始显现，主人们可以开始训练它们开始定点便便，对环境做一个完全的认知。'
    },
    {
      'title':'发育完全后的成犬饲养',
      'author':'宠物百科全书',
      'tag': '驯养建议',
      'categoryId': 2, // 假设"宠物饲养基础"的ID是2
      'date':'2021-11-25',
      'imagePath': 'assets/postDetail/post3.jpg',
      'content': '在安全健康地度过发育期以后，主人们就要开始考虑变换养育方式了哦。对于柔弱的幼犬，主人们往往都会悉心照料，但成年以后的狗狗是最有活力的时期，这个时期建议散养，多带狗狗出门运动，提高消化和代谢能力。'
    },
    {
      'title':'狗狗的日常养护',
      'author':'宠物百科全书',
      'tag': '驯养建议',
      'categoryId': 2, // 假设"宠物饲养基础"的ID是2
      'date':'2022-1-20',
      'imagePath': 'assets/postDetail/post4.png',
      'content': '狗狗的被毛也是惹人喜欢的原因之一，但是在日常的喂养中也要注重护理，不然可能会出现掉毛的现象，某些犬种还有可能出现被毛褪色的问题。'
    },
    {
      'title':'清洁狗狗耳朵',
      'author':'爱狗小贴士',
      'tag': '清洁建议',
      'categoryId': 3, // 假设"宠物饲养基础"的ID是2
      'date':'2022-2-30',
      'imagePath': 'assets/postDetail/post5.jpg',
      'content': '狗狗耳朵中经常会积聚一些污物，而且成年犬经常出门玩耍，也可能会让耳朵中沾上寄生虫。耳朵中的积水如果不及时清理会加剧感染。常见的寄生虫就有耳螨，这种寄生虫极具传染性，不及时清理会导致狗狗耳朵红肿、瘙痒、发炎，给狗狗带来剧烈疼痛。'
    }
  ];

  for (var post in posts) {
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



