
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
  // late DailyRecord dailyRecordToday;
  List<DailyRecord> dailyRecordsToday = [];
  // DailyRecord todayRecord = DailyRecord(recordDate: recordDate)
  // DailyRecord dailyRecordToday =

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    final allDailyRecords = await dbManager.getAllDailyRecords();
    final allHabits = await dbManager.getAllHabits();
    final today = await dbManager.getDailyRecord(DateTime.now());

    setState(() {
      dailyRecords = allDailyRecords;
      habits = allHabits;
      // dailyRecordsToday.add(today!);
      if (dailyRecords.isNotEmpty) {
        dailyRecordsToday.add(dailyRecords.first);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // if (dailyRecords.isEmpty) {
    //   return CircularProgressIndicator(); // 举例，你可以使用加载指示器
    // }
    // final record;

    int _exerciseGoal_default = 60;
    int _exerciseCompleted_default=20;
    int _nutritionGoal_default= 1000;
    int _nutritionCompleted_default=600;
    int _waterGoal_default=400;
    int _waterCompleted_default=20;
    int? _exerciseGoal;
    int? _exerciseCompleted;
    int? _nutritionGoal;
    int? _nutritionCompleted;
    int? _waterGoal;
    int? _waterCompleted;
    if (dailyRecordsToday.length>0) {
      final record = dailyRecordsToday[dailyRecordsToday.length-1];
      _exerciseGoal = record.exerciseGoal;
      _exerciseCompleted=record.exerciseCompleted;
      _nutritionGoal= record.nutritionGoal;
      _nutritionCompleted=record.nutritionCompleted;
      _waterGoal=record.waterGoal;
      _waterCompleted=record.waterCompleted;
      print('今日的活力值记录：');
      print('运动目标：${record.exerciseGoal ?? 0}'); // 如果为空，将其视为 0
      print('完成运动：${record.exerciseCompleted ?? 0}'); // 如果为空，将其视为 0
      print('营养目标：${record.nutritionGoal ?? 0}'); // 如果为空，将其视为 0
      print('完成营养：${record.nutritionCompleted ?? 0}'); // 如果为空，将其视为 0
      print('饮水目标：${record.waterGoal ?? 0}'); // 如果为空，将其视为 0
      print('完成饮水：${record.waterCompleted ?? 0}'); // 如果为空，将其视为 0

    }

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
              exerciseGoal: _exerciseGoal ?? _exerciseGoal_default,
              exerciseCompleted: _exerciseCompleted ?? 0,
              nutritionGoal: _nutritionGoal ?? _nutritionGoal_default,
              nutritionCompleted: _nutritionCompleted ?? 0,
              waterGoal: _waterGoal ?? _waterGoal_default,
              waterCompleted: _waterCompleted ?? 0,
              isFirstPage: true,

            ),

          ),
        ],
      ),
    );
  }
}


/// 每日记录活力值板块
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
}