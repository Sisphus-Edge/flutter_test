import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:untitled/db/DailyRecordDB/dailyrecord_db_manager.dart';
import 'package:drift/drift.dart' as drift;

import 'numeric/numeric_container.dart';
import 'habit/habit_container.dart';


class DailyPage extends StatefulWidget {
  final DateTime date;

  DailyPage({required this.date});

  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  

  final dbManager = DailyRecordDBManager();
  List<DailyRecord> dailyRecords = [];
  List<Habit> habits = [];
  List<DailyRecord> dailyRecordsToday = [];


  @override
  void initState() {
    super.initState();
    // initializeData();
  }


  // void initializeData() async {
  //   final allDailyRecords = await dbManager.getAllDailyRecords();
  //   final allHabits = await dbManager.getAllHabits();
  //   final today = await dbManager.getDailyRecord(DateTime.now());
  //
  //   // 在调用 setState 之前，检查当前 State 是否仍然有效
  //   if (mounted) {
  //     setState(() {
  //       dailyRecords = allDailyRecords;
  //       habits = allHabits;
  //       dailyRecordsToday.add(today!);
  //     });
  //   }
  // }

  Future<void> checkAndCreateDailyRecord() async {
    // 获取今天的日期
    DateTime today = DateTime.now();
    // 查询今天的每日记录
    DailyRecord? existingRecord = await DailyRecordDBManager().getDailyRecord(today);
    if (existingRecord == null) {
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
    } else {
      print('Daily record for today already exists.');
    }
  }

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
    // checkAndCreateDailyRecord();
    // printDatabaseInfo();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    late List<int> numericArray; // 初始化一个六位的int数组

    List<int> values = [
      dailyRecordsToday.isNotEmpty ? dailyRecordsToday.last.exerciseGoal ?? 40 : 40,
      dailyRecordsToday.isNotEmpty ? dailyRecordsToday.last.exerciseCompleted ?? 10 : 10,
      dailyRecordsToday.isNotEmpty ? dailyRecordsToday.last.nutritionGoal ?? 1000 : 1000,
      dailyRecordsToday.isNotEmpty ? dailyRecordsToday.last.nutritionCompleted ?? 500 : 500,
      dailyRecordsToday.isNotEmpty ? dailyRecordsToday.last.waterGoal ?? 400 : 400,
      dailyRecordsToday.isNotEmpty ? dailyRecordsToday.last.waterCompleted ?? 100 : 100,
      dailyRecordsToday.isNotEmpty ? dailyRecordsToday.last.score ?? 2 : 2,
    ];


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '每日记录',
          style: TextStyle(
            fontFamily: "ZHUOKAI",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 顶部时间
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                '${widget.date.year}-${widget.date.month}-${widget.date.day}',
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'ZHUOKAI',
                ),
                textAlign: TextAlign.left,
              ),
            ),

            Container(
              color: Colors.grey[100], // 你可以将这里的颜色改为你想要的颜色
              child: const SizedBox(height: 20),
            ),            /// 调用今日活力值板块
            NumericContainer(width: screenWidth * 0.95, height: screenHeight * 0.5, myIntArray: values),

            Container(
              color: Colors.grey[100], // 你可以将这里的颜色改为你想要的颜色
              child: const SizedBox(height: 20),
            ),
            /// 此板块调用习惯打卡板块
            MultiRowBlock(quantity: 2, section_width: screenWidth,),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
