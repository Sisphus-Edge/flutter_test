/*
/// 本文件已弃用 文件内容合并到numeric_firstpage & numeric_dailypage
///
import 'package:flutter/material.dart';

import '../../../db/DailyRecordDB/dailyrecord_db_manager.dart';
import 'numeric_input.dart';
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
    _fetchTodayDataFromDatabase();
  }

  Future<void> _fetchTodayDataFromDatabase() async {
    // 调用数据库管理器从数据库中获取今日数据
    // 例如：DailyRecord? todayRecord = await DailyRecordDBManager().getDailyRecord(DateTime.now());
    // 这里假设 DailyRecordDBManager 中有一个获取今日记录的方法 getDailyRecord(DateTime date)
    DailyRecord? todayRecord = await DailyRecordDBManager().getDailyRecord(DateTime.now());

    // 更新状态
    if (todayRecord != null) {
      setState(() {
        exerciseGoal = todayRecord.exerciseGoal ?? 0;
        exerciseCompleted = todayRecord.exerciseCompleted ?? 0;
        nutritionGoal = todayRecord.nutritionGoal ?? 0;
        nutritionCompleted = todayRecord.nutritionCompleted ?? 0;
        waterGoal = todayRecord.waterGoal ?? 0;
        waterCompleted = todayRecord.waterCompleted ?? 0;
      });
    }
  }


  void updateState({
    required int newExerciseGoal,
    required int newExerciseCompleted,
    required int newNutritionGoal,
    required int newNutritionCompleted,
    required int newWaterGoal,
    required int newWaterCompleted,
  }) {
    setState(() {
      exerciseGoal = newExerciseGoal;
      exerciseCompleted = newExerciseCompleted;
      nutritionGoal = newNutritionGoal;
      nutritionCompleted = newNutritionCompleted;
      waterGoal = newWaterGoal;
      waterCompleted = newWaterCompleted;
    });
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
    if(isfirstpage == true){
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
    }
    else {
      switch (identifier) {
        case 0:
          row = _buildRow(0,exerciseGoal, exerciseCompleted);
          break;
        case 1:
          row = _buildRow(1,nutritionGoal, nutritionCompleted);
          break;
        case 2:
          row = _buildRow(2,waterGoal, waterCompleted);
          break;
        default:
          row = Container(); // 或者返回一个空容器，或者抛出异常，取决于具体需求
      }
    }
    return row;
  }

  Widget _buildRow(int id_Row1, int goal, int bingo) {
    return Row(
      children: [
        DoubleLayerExpanded(id:id_Row1, data:goal, identifier: '目标'),
        Divider(height: globalItemHeight, color: Colors.black), // 添加分割线
        DoubleLayerExpanded(id:id_Row1, data:bingo, identifier: '已完成'),
        Divider(height: globalItemHeight, color: Colors.black), // 添加分割线
        DoubleLayerExpandedTrue(id:id_Row1, data:goal - bingo, identifier: '还需完成'),
      ],
    );
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
*/

/// 以下已经收录在numeric_input里面
