
import 'package:flutter/material.dart';
import 'numeric_activity.dart';
import 'package:ff_stars/ff_stars.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:untitled/db/DailyRecordDB/dailyrecord_db_manager.dart';
import 'numeric_input.dart';
import 'package:intl/intl.dart';


/// 一级界面活力值板块
class MyGridViewContainer extends StatefulWidget {
  final double width;
  final double height;

  const MyGridViewContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _MyGridViewContainerState createState() => _MyGridViewContainerState();
}

class _MyGridViewContainerState extends State<MyGridViewContainer> {
  final dbManager = DailyRecordDBManager();
  List<DailyRecord> dailyRecords = [];
  List<Habit> habits = [];
  List<DailyRecord> dailyRecordsToday = [];

  late Future<void> _future;


  int _exerciseGoal_default = 10;
  int _exerciseCompleted_default=20;
  int _nutritionGoal_default= 1000;
  int _nutritionCompleted_default=600;
  int _waterGoal_default=400;
  int _waterCompleted_default=20;

  int _exerciseGoal = 40;
  int _exerciseCompleted = 0;
  int _nutritionGoal = 10;
  int _nutritionCompleted =0;
  int _waterGoal = 400;
  int _waterCompleted = 0;
  int score = 3;

  @override
  void initState() {
    _future = getTodayRecordValues();
    super.initState();
  }

  /// 查看今日是否记录，没有就创建一条
  Future<void> getTodayRecordValues() async {
    // 获取今天的日期
    DateTime now = DateTime.now();

    int year = now.year;
    int month = now.month;
    int day = now.day;

    // 创建 DailyRecordDBManager 实例
    DailyRecordDBManager dbManager = DailyRecordDBManager();
    // 查询数据库中所有的 DailyRecord 记录
    List<DailyRecord> allRecords = await dbManager.getAllDailyRecords();


    for (DailyRecord record in allRecords) {
      if (record.recordDate.year == year &&
          record.recordDate.month == month &&
          record.recordDate.day == day) {
        print('一级界面取得信息');
        DailyRecord todayRecord = record;
        _exerciseGoal = todayRecord.exerciseGoal ?? _exerciseGoal_default;
        _exerciseCompleted = todayRecord.exerciseCompleted ??_exerciseGoal_default;
        _nutritionGoal = todayRecord.nutritionGoal ?? _exerciseCompleted_default;
        _nutritionCompleted = todayRecord.nutritionCompleted ?? _nutritionGoal_default;
        _waterGoal = todayRecord.waterGoal ?? _nutritionCompleted_default;
        _waterCompleted = todayRecord.waterCompleted ?? _waterGoal_default;
        score = todayRecord.score ?? _waterCompleted_default;
        print('1_exerciseGoal: $_exerciseGoal');
        print('1_exerciseCompleted: $_exerciseCompleted');
        print('1_nutritionGoal: $_nutritionGoal');
        print('1_nutritionCompleted: $_nutritionCompleted');
        print('1_waterGoal: $_waterGoal');
        print('1_waterCompleted: $_waterCompleted');
        print('1score: $score');

        break;
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    // getTodayRecordValues();


    print('_exerciseGoal: $_exerciseGoal');
    print('_exerciseCompleted: $_exerciseCompleted');
    print('_nutritionGoal: $_nutritionGoal');
    print('_nutritionCompleted: $_nutritionCompleted');
    print('_waterGoal: $_waterGoal');
    print('_waterCompleted: $_waterCompleted');
    print('score: $score');

    // return FutureBuilder(future: _future, builder: (BuildContext context, snapshot)){}
    return Container(
      width: widget.width,
      height: widget.height,
      child: FutureBuilder(future: _future, builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text('Error: ${snapshot.error}');
        }else{
          // return Text('Data: $_nutritionGoal');
          return Container(
            width: widget.width,
            height: widget.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '爱宠今日活力值',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ZHUOKAI',
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16), // 添加间距
                // 第二排
                Expanded(
                  child: MyGridView(
                    width: widget.width,
                    height: widget.height * 0.7,
                    state: true,
                    exerciseGoal: _exerciseGoal,
                    exerciseCompleted: _exerciseCompleted,
                    nutritionGoal: _nutritionGoal,
                    nutritionCompleted: _nutritionCompleted,
                    waterGoal: _waterGoal,
                    waterCompleted: _waterCompleted,
                    isFirstPage: true,

                  ),

                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

