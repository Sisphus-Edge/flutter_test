import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'post_db_manager.g.dart'; // Drift 会生成这个文件

@DriftDatabase(
  include: {'PostTables.drift'}, // 引入表文件
)
class PostDBManager extends _$PostDBManager {
  PostDBManager._privateConstructor(): super(_openConnection());
  static final PostDBManager _instance = PostDBManager._privateConstructor();

  factory PostDBManager() {
    return _instance;
  }
  @override
  int get schemaVersion => 1; // 版本号

  // 在 PostDBManager 类中添加以下方法

  // 增加一个分类
  Future<int> addCategory(CategoriesCompanion category) async {
    return await into(categories).insert(category);
  }

  // 删除一个分类
  Future<int> deleteCategory(int id) async {
    return await (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
  }

  // 更新一个分类
  Future<bool> updateCategory(Category category) async {
    return await update(categories).replace(category);
  }

  // 获取一个分类
  Future<Category?> getCategoryById(int id) async {
    return (select(categories)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
// 获取分类名称
  Future<Category?> getCategoryByName(String name) async {
    return (select(categories)..where((tbl) => tbl.name.equals(name))).getSingleOrNull();
  }

// 根据分类ID获取分类名
  Future<String> getCategoryNameById(int id) async {
    final query = select(categories)..where((tbl) => tbl.id.equals(id));
    final result = await query.getSingleOrNull();
    return result?.name ?? 'Unknown Category';
  }

// 获取所有分类
  Future<List<Category>> getAllCategories() async {
    return await select(categories).get();
  }

// 添加一个post
  Future<int> addPost(PostsCompanion post) async {
    return await into(posts).insert(post);
  }

// 删除一个post
  Future<int> deletePost(int id) async {
    return await (delete(posts)..where((tbl) => tbl.id.equals(id))).go();
  }

// 更新一个post
  Future<bool> updatePost(Post post) async {
    return await update(posts).replace(post);
  }

// 根据分类ID获取post列表
  Future<List<Post>> fetchPostsByCategoryId(int categoryId) async {
    return (select(posts)..where((tbl) => tbl.categoryId.equals(categoryId))).get();
  }

// 获取帖子标题
  Future<Post?> getPostByTitle(String title) async {
    return (select(posts)..where((tbl) => tbl.title.equals(title))).getSingleOrNull();
  }
// 获取特定post的详细信息
  Future<Post?> getPostDetails(int id) async {
    return (select(posts)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

// 获取所有post
  Future<List<Post>> getAllPosts() async {
    return await select(posts).get();
  }

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'post_library.db')); // 数据库名
    print("数据库文件路径: ${file.path}"); // 打印数据库文件路径
    return NativeDatabase(file);
  });
}