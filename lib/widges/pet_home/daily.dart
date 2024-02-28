import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:untitled/db/DailyRecordDB/dailyrecord_db_manager.dart';

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
    initializeData();
  }

  Future<void> initializeData() async {
    final allDailyRecords = await dbManager.getAllDailyRecords();
    final allHabits = await dbManager.getAllHabits();
    DateTime now = DateTime.now();
    DateTime todaytime = DateTime(now.year, now.month, now.day);
    final today = await dbManager.getDailyRecord(todaytime);

    setState(() {
      dailyRecords = allDailyRecords;
      habits = allHabits;
      dailyRecordsToday.add(today!);

    });
  }

  @override
  Widget build(BuildContext context) {
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
