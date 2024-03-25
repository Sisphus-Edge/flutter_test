import 'package:flutter/material.dart';

import 'package:untitled/widges/pet_home/top_section_pethome.dart';
import 'package:untitled/widges/pet_home/canlendar_pet_home.dart';
import 'package:untitled/widges/pet_home/numeric/numeric_container.dart';
import 'package:untitled/widges/pet_home/habit/habit_container.dart';
import 'package:untitled/db/DailyRecordDB/dailyrecord_db_manager.dart';
import 'package:drift/drift.dart' as drift;

class PetHomeRoute extends StatefulWidget {
  const PetHomeRoute({super.key,required this.MediaWidth, required this.MediaHeight});
  final double MediaWidth;
  final double MediaHeight;

  @override
  _PetHomeRouteState createState() => _PetHomeRouteState();

}

class _PetHomeRouteState extends State<PetHomeRoute> {

  late double sharedMediaWidth;
  late double sharedMediaHeight;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 查看今日是否记录，没有就创建一条
  Future<void> checkAndCreateDailyRecord() async {
    // 获取今天的日期
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year,now.month,now.day);
    // 查询今天的每日记录
    // DailyRecord? existingRecord = await DailyRecordDBManager().getDailyRecord(today);

    int year = now.year;
    int month = now.month;
    int day = now.day;

    // 创建 DailyRecordDBManager 实例
    DailyRecordDBManager dbManager = DailyRecordDBManager();
    // 查询数据库中所有的 DailyRecord 记录
    List<DailyRecord> allRecords = await dbManager.getAllDailyRecords();

    bool isestablished = false;

    for (DailyRecord record in allRecords) {
      if (record.recordDate.year == year &&
          record.recordDate.month == month &&
          record.recordDate.day == day) {
        print('Daily record for today already exists.');
        isestablished = true;
        break;
      }
      else{
        isestablished = false;
      }
    }

    // if (DailyRecordDBManager().getDailyRecord(today)==null) {
    if(isestablished == false){
      // 如果不存在今天的记录，则创建一个新的记录
      final newRecord = DailyRecordsCompanion(
        recordDate: drift.Value.ofNullable(today),
        exerciseGoal: drift.Value(40),
        exerciseCompleted: drift.Value(0),
        nutritionGoal: drift.Value(800),
        nutritionCompleted: drift.Value(0),
        waterGoal: const drift.Value(400),
        waterCompleted: const drift.Value(0),
      );
      // 将新记录插入到数据库中
      await DailyRecordDBManager().addDailyRecord(newRecord as DailyRecordsCompanion);
      print('Created a new daily record for today.');
    }
  }

  /// 删除特定日期的记录
  Future<void> deleteDailyRecordByDate() async {
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    int day = now.day;

    // 创建 DailyRecordDBManager 实例
    DailyRecordDBManager dbManager = DailyRecordDBManager();

    // 查询数据库中所有的 DailyRecord 记录
    List<DailyRecord> allRecords = await dbManager.getAllDailyRecords();

    // 遍历查询结果，删除与今天日期相同的记录
    for (DailyRecord record in allRecords) {
      if (record.recordDate.year == year &&
          record.recordDate.month == month &&
          record.recordDate.day == day) {
        // 删除记录
        await dbManager.deleteDailyRecord(record.recordDate);
      }
    }

  }

  /// 打印特定日期或者全部记录
  Future<void> printDatabaseInfo() async {
    // 获取所有习惯
    List<Habit> habits = await DailyRecordDBManager().getAllHabits();

    // 打印习惯信息
    print('Habits:');
    habits.forEach((habit) {
      print('Habit ID: ${habit.habitId}, Habit Name: ${habit.habitName}');
    });

    // 获取所有每日记录
    List<DailyRecord> dailyRecords = await DailyRecordDBManager().getAllDailyRecords();

    // 打印每日记录信息
    print('\nDaily Records:');
    dailyRecords.forEach((record) {
      print('Date: ${record.recordDate}');
      print('Exercise Goal: ${record.exerciseGoal}');
      print('Exercise Completed: ${record.exerciseCompleted}');
      print('Nutrition Goal: ${record.nutritionGoal}');
      print('Nutrition Completed: ${record.nutritionCompleted}');
      print('Water Goal: ${record.waterGoal}');
      print('Water Completed: ${record.waterCompleted}');
      print('-----------------------------');
    });
  }

  @override
  Widget build(BuildContext context) {
    checkAndCreateDailyRecord();
    // deleteDailyRecordByDate();
    // printDatabaseInfo();
    sharedMediaWidth = widget.MediaWidth;
    sharedMediaHeight = widget.MediaHeight;

    return Container(
      // color: Colors.grey,
      child: Container(
        // child: MyApp(),
        padding: EdgeInsets.symmetric(horizontal: sharedMediaWidth *0.03,vertical: sharedMediaHeight*0.015),
        child: Column(
            children: [
              FittedBox(
                fit: BoxFit.contain, // 限制子部件的大小，确保其不会超出容器的边界
                child: TopSection(section_width: sharedMediaWidth * 0.97, section_height: sharedMediaHeight*0.16), // 添加您想要显示的内容

              ),
              // sizeOf(hie),
              Divider(
                color: Colors.transparent,
                height: sharedMediaHeight * 0.01,
              ),
              Canlendar_petHome(section_width: sharedMediaWidth * 0.97, section_height: sharedMediaHeight*0.16),
              Divider(
                color: Colors.transparent,
                height: sharedMediaHeight * 0.01,
              ),
              // MyGridView(width: sharedMediaWidth * 0.97, height: sharedMediaHeight*0.25),
              // 到此 width剩下0.0445
              /// 爱宠今日活力值
              MyGridViewContainer(width: sharedMediaWidth * 0.97, height: sharedMediaHeight*0.3),
              Divider(
                color: Colors.transparent,
                height: sharedMediaHeight * 0.015,
              ),
              /// 每周习惯完成情况
              ContainerWithWeekGridView(width: sharedMediaWidth*0.97, height: sharedMediaHeight*0.144,
              identifier: [false,false,true,true,true,false,true],
              )
              // MyHomePage(),
              // 仅供测试
            ]
        ),
      ),
    );  }
}


