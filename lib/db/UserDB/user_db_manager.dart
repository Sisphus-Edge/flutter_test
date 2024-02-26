import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
//引入我们的userInfo表结构，来存储一条合适的用户信息
import 'UserInfo.dart';
part 'user_db_manager.g.dart'; // Drift 会自动生成

@DriftDatabase(
  include: {'UserTable.drift'}, // 确保文件名正确
)
class UserDBManager extends _$UserDBManager {
  UserDBManager._privateConstructor() : super(_openConnection());
  static final UserDBManager _instance = UserDBManager._privateConstructor();

  factory UserDBManager() {
    return _instance;
  }

  @override
  int get schemaVersion => 1;

  Future<int> addUser(UsersCompanion data) async {
    return into(users).insert(data);
  }

  Future<int> deleteUser(int id) async {
    return (delete(users)..where((t) => t.id.equals(id))).go();
  }

  Future<bool> updateUser(User user) async {
    return update(users).replace(user);
  }

  Future<User?> getUserByEmail(String email) async {
    return (select(users)..where((t) => t.email.equals(email))).getSingleOrNull();
  }

  // 验证用户的邮箱和密码
  Future<User?> validateUser(String email, String password) async {
    final query = select(users)..where((u) => u.email.equals(email));
    final user = await query.getSingleOrNull();
    if (user != null && user.password == password) {
      // 注意: 实际应用中应该对密码进行加密处理
      return user;
    }
    return null;
  }

  Future<List<User>> getAllUsers() async {
    return select(users).get();
  }

  Future<bool> updateUserPassword(String email, String newPassword) async {
    final query = select(users)..where((u) => u.email.equals(email));
    final user = await query.getSingleOrNull();
    if (user != null) {
      // 使用write方法更新密码，并检查受影响的行数
      int updatedRows = await (update(users)..where((u) => u.email.equals(email))).write(
        UsersCompanion(password: Value(newPassword)),
      );
      // 如果有行受到影响，则表示更新成功
      return updatedRows > 0;
    }
    // 如果用户不存在，则返回false
    return false;
  }

  //根际邮箱来获得一个合适的UserInfo
  Future<UserInfo?> getUserInfo(String email) async {
    final query = select(users)..where((u) => u.email.equals(email));
    final user = await query.getSingleOrNull();
    if (user != null) {
      return UserInfo(
        id: user.id,
        email: user.email,
        name: user.name ?? '未设置用户名', // 如果name为空，则返回默认值
        avatar: user.avatar ?? 'assets/image/login/1.png', // 如果avatar为空，则返回默认头像路径
        address: user.address ?? '未设置地址', // 如果address为空，则返回默认值
      );
    }
    return null;
  }

  Future<bool> updateUserProfile(int userId, String name, String avatar, String address) async {
    final userUpdate = UsersCompanion(
      name: Value(name),
      avatar: Value(avatar),
      address: Value(address),
    );
    return await (update(users)..where((tbl) => tbl.id.equals(userId))).write(userUpdate) > 0;
  }


}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'user_library.db')); // 数据库名
    return NativeDatabase(file);
  });
}
