/// 预备弃用 合并到daily.dart中
import 'package:flutter/material.dart';
import 'package:ff_stars/ff_stars.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:untitled/db/DailyRecordDB/dailyrecord_db_manager.dart';
import 'numeric_input.dart';
double globalItemHeight = 100; // 全局变量用于itemheight
// 第二排的height直接在DoubleLayerExpanded中实现
int _gobalItemIndex = 0;

/// 每日记录活力值板块
class NumericContainer extends StatelessWidget {
  final double width;
  final double height;
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

  // 用于记录第一排哪个元素被点击了
  int _selectedItemIndex = 0;
  late int exerciseGoal;
  late int exerciseCompleted;
  late int nutritionGoal;
  late int nutritionCompleted;
  late int waterGoal;
  late int waterCompleted;
  late double width;

  @override
  void initState() {
    super.initState();
    width = widget.width;
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
      width:width,
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
