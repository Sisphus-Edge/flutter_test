import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'dailyrecord_db_manager.g.dart'; // Drift 会生成这个文件

@DriftDatabase(
  include: {'daily_record.drift'}, // 引入表文件
)


class DailyRecordDBManager extends _$DailyRecordDBManager {
  // DailyRecordDBManager() : super(_openConnection());
  DailyRecordDBManager._privateConstructor(): super(_openConnection());
  static final DailyRecordDBManager _instance = DailyRecordDBManager._privateConstructor();

  factory DailyRecordDBManager() {
    return _instance;
  }

  @override
  int get schemaVersion => 1;

// 添加一个每日记录
  Future<int> addDailyRecord(DailyRecordsCompanion record) async {
    return await into(dailyRecords).insert(record);
  }

// 删除一个每日记录
  Future<int> deleteDailyRecord(DateTime recordDate) async {
    return await (delete(dailyRecords)..where((r) => r.recordDate.equals(recordDate))).go();
  }

// 更新一个每日记录
  Future<bool> updateDailyRecord(DailyRecordsCompanion record) async {
    return await update(dailyRecords).replace(record);
  }

  // // 更新特定日期的每日记录
  // Future<bool> updateDailyRecord(DateTime recordDate, DailyRecordsCompanion updatedRecord) async {
  //   return await (update(dailyRecords)..where((r) => r.recordDate.equals(recordDate))).replace(updatedRecord);
  // }

// 获取特定日期的每日记录
  Future<DailyRecord?> getDailyRecord(DateTime recordDate) async {
    final query = select(dailyRecords)..where((r) => r.recordDate.equals(recordDate));
    return query.getSingleOrNull();
  }

// 获取所有每日记录
  Future<List<DailyRecord>> getAllDailyRecords() async {
    return await select(dailyRecords).get();
  }

  // 添加一个习惯
  Future<int> addHabit(HabitsCompanion habit) async {
    return await into(habits).insert(habit);
  }

// 删除一个习惯
  Future<int> deleteHabit(int habitId) async {
    return await (delete(habits)..where((h) => h.habitId.equals(habitId))).go();
  }

// 更新一个习惯
  Future<bool> updateHabit(HabitsCompanion habit) async {
    return await update(habits).replace(habit);
  }

// 根据开始日期和结束日期获取习惯列表
  Future<List<Habit>> fetchHabitsByDateRange(DateTime startDate, DateTime endDate) async {
    final query = select(habits)..where((h) => h.startDate.isBetweenValues(startDate, endDate));
    return query.get();
  }

// 获取特定习惯的详细信息
  Future<Habit?> getHabitDetails(int habitId) async {
    final query = select(habits)..where((h) => h.habitId.equals(habitId));
    return query.getSingleOrNull();
  }
  // 根据习惯名字获取习惯
  Future<Habit?> getHabitByName(String name) async {
    final query = select(habits)..where((t) => t.habitName.equals(name));
    return await query.getSingleOrNull();
  }

// 获取所有习惯
  Future<List<Habit>> getAllHabits() async {
    return await select(habits).get();
  }
}


LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'daily_record_library.db')); // 数据库名
    print("数据库文件路径: ${file.path}"); // 打印数据库文件路径
    return NativeDatabase(file);
  });
}
