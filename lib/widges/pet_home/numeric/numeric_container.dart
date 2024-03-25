/*
/// 本文件已弃用 文件内容合并到numeric_firstpage & numeric_dailypage

import 'package:flutter/material.dart';
import 'numeric_activity.dart';
import 'package:ff_stars/ff_stars.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:untitled/db/DailyRecordDB/dailyrecord_db_manager.dart';


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


/// 每日记录活力值板块
/// 和一级界面活力值板块调用同一个gridview
class NumericContainer extends StatelessWidget {
  final double width;
  final double height;
  // final int _exerciseGoal = 60;
  final List<int> myIntArray;


  const NumericContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.myIntArray,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.white,
      // padding: EdgeInsets.fromLTRB(width*0.1, top, width, width*0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// 今日活力值标题+打分板块
          Container(
            child: ScoreWidget(),
          ),
          SizedBox(height: height *0.05), // 添加间距
          /// 圆形进度显示框
          CircularPercentIndicator(
            radius: height * 0.18,
            lineWidth: 15.0,
            percent: 0.45,
            center: const Text("45%",
            style: TextStyle(fontSize: 18,fontFamily: 'ZHUOKAI'),),
            progressColor: const Color(0XFF726EF0),
            backgroundColor: Colors.grey,
            animation: true,
            animationDuration: 700,
          ),
          // 第二排
          SizedBox(height: height *0.05), // 添加间距
          Expanded(
            child: MyGridView(width: width,height: height*0.40,state: true,
              exerciseGoal: myIntArray[0],
              exerciseCompleted: myIntArray[1],
              nutritionGoal: myIntArray[2],
              nutritionCompleted: myIntArray[3],
              waterGoal: myIntArray[4],
              waterCompleted: myIntArray[5],
              isFirstPage: false,
            ), // 调用显示 MyGridView 的部分
          ),
          // if(MyGridVi)
        ],
      ),
    );
  }
}


/// 今日活力值打分板块
class ScoreWidget extends StatefulWidget {
  const ScoreWidget({Key? key}) : super(key: key);

  @override
  _ScoreWidgetState createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  bool _justShow = true; // 默认值

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 左侧标题
        const Text(
          '今日活力值',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'ZHUOKAI',
            color: Colors.black87,
          ),
        ),
        FFStars(
          normalStar: const Icon(Icons.star, size: 30, color: Colors.grey,), /// 未选中的星星
          selectedStar: const Icon(Icons.star, size: 30, color: Colors.orange,),/// 选中的星星
          starsChanged: (realStars, choosedStars) {
            print("实际选择: ${choosedStars}, 最终得分: ${realStars}");
          },
          step: 0.01,/// 用于设置半星(0.5), 整星(1.0), 任意星(0.01), 可在0.01 - 1.0之间自定义, 默认值为0.01
          defaultStars: 4,/// 默认有几颗星星, 默认值为0
          starMargin: 2,/// 星星间的间距, 默认10
          justShow: _justShow,/// 是否仅做展示, 默认false
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _justShow = !_justShow; // 切换值
            });
          },
          child: const Icon(
            Icons.check_circle,
            size: 30,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}*/
