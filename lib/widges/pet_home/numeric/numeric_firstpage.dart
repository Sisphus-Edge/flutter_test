
import 'package:flutter/material.dart';
import 'package:untitled/db/DailyRecordDB/dailyrecord_db_manager.dart';
import 'numeric_input.dart';


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
        // print('1_exerciseGoal: $_exerciseGoal');
        // print('1_exerciseCompleted: $_exerciseCompleted');
        // print('1_nutritionGoal: $_nutritionGoal');
        // print('1_nutritionCompleted: $_nutritionCompleted');
        // print('1_waterGoal: $_waterGoal');
        // print('1_waterCompleted: $_waterCompleted');
        // print('1score: $score');

        break;
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    // getTodayRecordValues();


    // print('_exerciseGoal: $_exerciseGoal');
    // print('_exerciseCompleted: $_exerciseCompleted');
    // print('_nutritionGoal: $_nutritionGoal');
    // print('_nutritionCompleted: $_nutritionCompleted');
    // print('_waterGoal: $_waterGoal');
    // print('_waterCompleted: $_waterCompleted');
    // print('score: $score');

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

double globalItemHeight = 100; // 全局变量用于itemheight
// 第二排的height直接在DoubleLayerExpanded中实现
int _gobalItemIndex = 0;


class MyGridView extends StatefulWidget {
  final double width;
  final double height;
  final bool state;
  final int exerciseGoal;
  final int exerciseCompleted;
  final int nutritionGoal;
  final int nutritionCompleted;
  final int waterGoal;
  final int waterCompleted;
  final bool isFirstPage;
  /// state为true表示一级界面  state为false表示为每日记录
  const MyGridView({
    Key? key,
    required this.width,
    required this.height,
    required this.state,
    required this.exerciseGoal,
    required this.exerciseCompleted,
    required this.nutritionGoal,
    required this.nutritionCompleted,
    required this.waterGoal,
    required this.waterCompleted,
    required this.isFirstPage,
  }) : super(key: key);

  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  // 用于控制第二排元素的状态列表
  List<bool> _secondRowItemsStatus = [false, false, false];

  // 用于记录第一排哪个元素被点击了
  int _selectedItemIndex = 0;
  late int exerciseGoal;
  late int exerciseCompleted;
  late int nutritionGoal;
  late int nutritionCompleted;
  late int waterGoal;
  late int waterCompleted;

  @override
  void initState() {
    super.initState();
    exerciseGoal = widget.exerciseGoal;
    exerciseCompleted = widget.exerciseCompleted;
    nutritionGoal = widget.nutritionGoal;
    nutritionCompleted = widget.nutritionCompleted;
    waterGoal = widget.waterGoal;
    waterCompleted = widget.waterCompleted;
  }

  @override
  Widget build(BuildContext context) {
    final itemWidth = widget.width / 3;
    final itemHeight1 = widget.height / 5 * 2;
    globalItemHeight = widget.height / 5 * 3;

    return Container(
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
                      _gobalItemIndex = 0;
                      _secondRowItemsStatus = [true, false, false];
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
                      _secondRowItemsStatus = [false, true, false];
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
                      _secondRowItemsStatus = [false, false, true];
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
          // 添加第一排和第二排之间的分割线
          Divider(color: Colors.white),
          // 第二排
          // Column(
          // CustomRow(identifier: 1, height: globalItemHeight),
          SecondRow(
              _selectedItemIndex,
              widget.isFirstPage
          ),
          // Divider(color: Colors.white), // 第二排之间的分割线

        ],
      ),
    );
  }

  Widget SecondRow(int identifier,bool isfirstpage){
    Widget row;
      switch (identifier) {
        case 0:
          row = _buildRow2(0,exerciseGoal, exerciseCompleted);
          break;
        case 1:
          row = _buildRow2(1,nutritionGoal, nutritionCompleted);
          break;
        case 2:
          row = _buildRow2(2,waterGoal, waterCompleted);
          break;
        default:
          row = Container(); // 或者返回一个空容器，或者抛出异常，取决于具体需求
      }

    return row;
  }


  Widget _buildRow2(int id_Row1, int goal, int bingo){
    return Row(
      children: [
        DoubleLayerExpandedTrue(id:id_Row1, data:goal, identifier: '目标'),
        Divider(height: globalItemHeight, color: Colors.black), // 添加分割线
        DoubleLayerExpandedTrue(id:id_Row1, data:bingo, identifier: '已完成'),
        Divider(height: globalItemHeight, color: Colors.black), // 添加分割线
        DoubleLayerExpandedTrue(id:id_Row1, data:goal - bingo, identifier: '还需完成'),
      ],
    );
  }
}
