
import 'package:flutter/material.dart';
import 'package:untitled/db/DailyRecordDB/dailyrecord_db_manager.dart';
import 'package:drift/drift.dart' as drift;
import 'package:percent_indicator/percent_indicator.dart';


import 'numeric/numeric_dailypage.dart';
import 'habit/habit_container.dart';
import 'numeric/numeric_input.dart';

double globalItemHeight = 100; // 全局变量用于itemheight
// 第二排的height直接在DoubleLayerExpanded中实现
class DailyPage extends StatefulWidget {
  final DateTime date;

  DailyPage({required this.date});

  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
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

  final dbManager = DailyRecordDBManager();
  List<DailyRecord> dailyRecords = [];
  List<Habit> habits = [];
  List<DailyRecord> dailyRecordsToday = [];
  late Future<void> _future;
  late TextEditingController _controller;
  ValueNotifier<int> _exerciseGoalNotifier = ValueNotifier<int>(40);


  @override
  void initState() {
    _future = getTodayRecordValues();

    _exerciseGoalNotifier.addListener(_handleExerciseGoalChange);

    super.initState();
  }
  /// 获得今日记录
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
        print('2_exerciseGoal: $_exerciseGoal');
        print('2_exerciseCompleted: $_exerciseCompleted');
        print('2_nutritionGoal: $_nutritionGoal');
        print('2_nutritionCompleted: $_nutritionCompleted');
        print('2_waterGoal: $_waterGoal');
        print('2_waterCompleted: $_waterCompleted');
        print('2score: $score');

        break;
      }
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

  void _handleExerciseGoalChange() {
    // 当 _exerciseGoal 变化时执行的操作
    int newGoal = _exerciseGoalNotifier.value;
    // 在这里执行更新数据库的操作
    updateDatabase();
  }

  Future<void> updateDatabase() async {
    // 获取今天的日期
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    int day = now.day;

    // 创建 DailyRecordsCompanion 对象
    final updatedRecord = DailyRecordsCompanion(
      recordDate: drift.Value(DateTime(year, month, day)),
      exerciseGoal: drift.Value(_exerciseGoal),
      exerciseCompleted: drift.Value(_exerciseCompleted),
      nutritionGoal: drift.Value(_nutritionGoal),
      nutritionCompleted: drift.Value(_nutritionCompleted),
      waterGoal: drift.Value(_waterGoal),
      waterCompleted: drift.Value(_waterCompleted),
    );

    List<DailyRecord> allRecords = await dbManager.getAllDailyRecords();

    // 遍历查询结果，删除与今天日期相同的记录
    for (DailyRecord record in allRecords) {
      if (record.recordDate.year == year &&
          record.recordDate.month == month &&
          record.recordDate.day == day) {
        // 删除记录
        // bool isSuccess = await dbManager.updateDailyRecord(record.recordDate, updatedRecord);
        // if (isSuccess) {
          // 更新成功
          print('Record updated successfully.');
        } else {
          // 更新失败
          print('Failed to update record.');
        // }
      }
    }
  }

  late double screenWidth;
  late double screenHeight;
  int _selectedItemIndex = 0;



  @override
  Widget build(BuildContext context) {
    // printDatabaseInfo();

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    late List<int> numericArray; // 初始化一个六位的int数组


    // 用于记录第一排哪个元素被点击了
    final itemWidth = screenWidth *0.9 / 3;
    final itemHeight1 = screenHeight*0.2 / 5 * 2;
    globalItemHeight = screenHeight *0.2/ 5 * 3;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        title: const Text(
          '每日记录',
          style: TextStyle(
            fontFamily: "ZHUOKAI",
          ),
        ),
      ),
      body:  FutureBuilder(future: _future, builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text('Error: ${snapshot.error}');
        }else{
          return SingleChildScrollView(
            child: Column(
              children: [
                /// 顶部时间
                buildDateWidget(),
                buildDivider(),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child:ScoreWidget(),
                ),
                buildDivider(),

                buildCircularPercentIndicator(),

                buildDivider(),

                Container(
                  width:screenWidth*0.97,
                  decoration: BoxDecoration(
                    color: Color(0XFFEAEAEA), // 整个 MyGridView 的背景色为灰色
                    borderRadius: BorderRadius.circular(10), // 添加圆角
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // 外部阴影颜色和透明度
                        spreadRadius: 2, // 阴影扩散半径
                        blurRadius: 5, // 阴影模糊半径
                        offset: Offset(0, 2), // 阴影偏移量，控制阴影位置
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // 第一排
                      Row(
                        children: [
                          const SizedBox(width: 15), // 添加透明的水平分隔空间
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedItemIndex = 0;
                                });
                              },
                              child: Container(
                                // 此处container的大小也是button背景版的大小
                                height: itemHeight1*0.7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(15), // 设置圆角
                                  color: _selectedItemIndex == 0 ? Color(0XFF726EF0) : Colors.transparent,
                                  boxShadow:[
                                    BoxShadow(
                                      color: _selectedItemIndex == 0 ? Colors.grey.withOpacity(0.5) : Colors.transparent, // 外部阴影颜色和透明度
                                      blurRadius: 2, // 阴影模糊半径
                                      offset: Offset(0, 2), // 阴影偏移量，控制阴影位置
                                    ),
                                  ],
                                ),

                                child: Center(
                                  child: Text('锻炼',style: TextStyle(
                                    fontFamily: 'ZHUOKAI',
                                    letterSpacing: 2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    color: _selectedItemIndex == 0 ? Colors.white : Colors.black,
                                  ),),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 15), // 添加透明的水平分隔空间
                          // 摄入营养部分
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedItemIndex = 1;
                                });
                              },
                              child: Container(
                                // 此处container的大小也是button背景版的大小
                                height: itemHeight1*0.7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(15), // 设置圆角
                                  color: _selectedItemIndex == 1 ? Color(0XFF726EF0) : Colors.transparent,
                                  boxShadow:[
                                    BoxShadow(
                                      color: _selectedItemIndex == 1 ? Colors.grey.withOpacity(0.5) : Colors.transparent, // 外部阴影颜色和透明度
                                      blurRadius: 2, // 阴影模糊半径
                                      offset: Offset(0, 2), // 阴影偏移量，控制阴影位置
                                    ),
                                  ],
                                ),

                                child: Center(
                                  child: Text('摄入营养',style: TextStyle(
                                    fontFamily: 'ZHUOKAI',
                                    letterSpacing: 2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    color: _selectedItemIndex == 1 ? Colors.white : Colors.black,
                                  ),),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 15), // 添加透明的水平分隔空间
                          // 摄入水分部分
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedItemIndex = 2;
                                });
                              },
                              child: Container(
                                // 此处container的大小也是button背景版的大小
                                height: itemHeight1*0.7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(15), // 设置圆角
                                  color: _selectedItemIndex == 2 ? Color(0XFF726EF0) : Colors.transparent,
                                  boxShadow:[
                                    BoxShadow(
                                      color: _selectedItemIndex == 2 ? Colors.grey.withOpacity(0.5) : Colors.transparent, // 外部阴影颜色和透明度
                                      blurRadius: 2, // 阴影模糊半径
                                      offset: Offset(0, 2), // 阴影偏移量，控制阴影位置
                                    ),
                                  ],
                                ),

                                child: Center(
                                  child: Text('摄入水分',style: TextStyle(
                                    fontFamily: 'ZHUOKAI',
                                    letterSpacing: 2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    color: _selectedItemIndex == 2 ? Colors.white : Colors.black,
                                  ),),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 15), // 添加透明的水平分隔空间

                        ],
                      ),
                      /// 添加第一排和第二排之间的分割线
                      Divider(color: Colors.white),
                      SecondRow(
                          _selectedItemIndex,
                          false
                      ),
                    ],
                  ),
                ),

                /*MyGridView(width: screenWidth * 0.95, height: screenHeight*0.23, state: true,
                    exerciseGoal: _exerciseGoal,
                    exerciseCompleted: _exerciseCompleted,
                    nutritionGoal: _nutritionGoal,
                    nutritionCompleted: _nutritionCompleted,
                    waterGoal: _waterGoal,
                    waterCompleted: _waterCompleted,
                    isFirstPage: false),*/


                /// 调用今日活力值板块
                // NumericContainer(width: screenWidth * 0.95, height: screenHeight * 0.5, myIntArray: values),

                buildDivider(),

                /// 此板块调用习惯打卡板块
                MultiRowBlock(quantity: 2, section_width: screenWidth,),
                const SizedBox(height: 20),

              ],
            ),
          );
        }

      }),

    );

    /* return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        title: const Text(
          '每日记录',
          style: TextStyle(
            fontFamily: "ZHUOKAI",
          ),
        ),
      ),
      body:  FutureBuilder(future: _future, builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text('Error: ${snapshot.error}');
        }else{
          return SingleChildScrollView(
            child: Column(
              children: [
                /// 顶部时间
                buildDateWidget(),
                buildDivider(),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child:ScoreWidget(),
                ),
                buildDivider(),

                buildCircularPercentIndicator(),

                buildDivider(),

                MyGridView(width: screenWidth * 0.95, height: screenHeight*0.23, state: true,
                    exerciseGoal: _exerciseGoal,
                    exerciseCompleted: _exerciseCompleted,
                    nutritionGoal: _nutritionGoal,
                    nutritionCompleted: _nutritionCompleted,
                    waterGoal: _waterGoal,
                    waterCompleted: _waterCompleted,
                    isFirstPage: false),
                /// 调用今日活力值板块
                // NumericContainer(width: screenWidth * 0.95, height: screenHeight * 0.5, myIntArray: values),

                buildDivider(),

                /// 此板块调用习惯打卡板块
                MultiRowBlock(quantity: 2, section_width: screenWidth,),
                const SizedBox(height: 20),

              ],
            ),
          );
        }

      }),

    );*/

  }
  Widget SecondRow(int identifier,bool isfirstpage){
    Widget row;
    switch (identifier) {
      case 0:
        row = _buildRow(0,_exerciseGoal, _exerciseCompleted);
        break;
      case 1:
        row = _buildRow(1,_nutritionGoal, _nutritionCompleted);
        break;
      case 2:
        row = _buildRow(2,_waterGoal, _waterCompleted);
        break;
      default:
        row = Container(); // 或者返回一个空容器，或者抛出异常，取决于具体需求
    }
    return row;
  }

  Widget _buildRow(int id_Row1, int goal, int bingo) {
    return Row(
      children: [
        buildSecondRow(id_Row1, goal,  '目标'),
        Divider(height: globalItemHeight, color: Colors.black), // 添加分割线
        buildSecondRow(id_Row1, bingo, '已完成'),
        Divider(height: globalItemHeight, color: Colors.black), // 添加分割线
        buildSecondRowNeeded(id_Row1, goal - bingo),
      ],
    );
  }

  /*Widget buildSecondRow(int id,int data,String identifier) {
    String lowerText = '';

    // 根据不同的 id 设置不同的字
    switch (id) {
      case 0:
        lowerText = 'min';
        break;
      case 1:
        lowerText = 'k';
        break;
      case 2:
        lowerText = 'ml';
        break;
      default:
        lowerText = 'min';
    }

    return Expanded(
      flex: 1,
      child: Container(
        height: globalItemHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  height: globalItemHeight * 0.4,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    '${identifier}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  height: globalItemHeight * 0.6,
                  padding: const EdgeInsets.only(top: 6),
                  child: TextFormField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixText: ' $lowerText',
                      suffixStyle: const TextStyle(fontSize: 18),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'ZCOOL',
                      letterSpacing: 1,
                      wordSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      // 更新数据
                      _updateData();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/
  Widget buildSecondRow(int id, int data, String identifier) {
    String lowerText = '';

    // 根据不同的 id 设置不同的字
    switch (id) {
      case 0:
        lowerText = 'min';
        break;
      case 1:
        lowerText = 'k';
        break;
      case 2:
        lowerText = 'ml';
        break;
      default:
        lowerText = 'min';
    }

    return Expanded(
      flex: 1,
      child: Container(
        height: globalItemHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  height: globalItemHeight * 0.4,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    '${identifier}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  height: globalItemHeight * 0.6,
                  padding: const EdgeInsets.only(top: 6),
                  child: TextFormField(
                    initialValue: data.toString(), // 设置输入框初始值
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixText: ' $lowerText',
                      suffixStyle: const TextStyle(fontSize: 18),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'ZCOOL',
                      letterSpacing: 1,
                      wordSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      // 根据 id 更新相应的变量
                      switch (id) {
                        case 0:
                          _exerciseGoal = int.tryParse(value) ?? _exerciseGoal_default;
                          break;
                        case 1:
                          _nutritionGoal = int.tryParse(value) ?? _nutritionGoal_default;
                          break;
                        case 2:
                          _waterGoal = int.tryParse(value) ?? _waterGoal_default;
                          break;
                      }
                      // 更新数据
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildSecondRowNeeded(int id,int data,) {
    String lowerText = '';

    // 根据不同的 id 设置不同的字
    switch (id) {
      case 0:
        lowerText = 'min';
        break;
      case 1:
        lowerText = 'k';
        break;
      case 2:
        lowerText = 'ml';
        break;
      default:
        lowerText = 'min';
    }

    return Expanded(
      flex: 1,
      child: Container(
        height: globalItemHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  height: globalItemHeight *0.4,
                  // color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 6), // 调整垂直方向上的内边距
                  child: const Text(
                    '还需完成',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  height: globalItemHeight *0.6,
                  // color: Colors.pink,
                  padding: const EdgeInsets.only(top: 6), // 调整垂直方向上的内边距
                  child: Text(
                    '$data $lowerText',
                    style: const TextStyle(fontSize: 18,fontFamily: 'ZCOOL',
                      letterSpacing: 1,wordSpacing: 1,),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateWidget(){
    return  Container(
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
    );
  }

  Widget buildCircularPercentIndicator(){
    return CircularPercentIndicator(
      radius: screenHeight * 0.09,
      lineWidth: 15.0,
      percent: 0.45,
      center: const Text("45%",
        style: TextStyle(fontSize: 18,fontFamily: 'ZHUOKAI'),),
      progressColor: const Color(0XFF726EF0),
      backgroundColor: Colors.grey,
      animation: true,
      animationDuration: 700,
    );
  }

  Widget buildDivider(){
    return  Container(
      color: Colors.grey[100], // 你可以将这里的颜色改为你想要的颜色
      child: const SizedBox(height: 20),
    );
  }
  Widget buildDivider2(){
    return  Container(
      color: Colors.grey[100], // 你可以将这里的颜色改为你想要的颜色
      child: const SizedBox(height: 10),
    );
  }

}


