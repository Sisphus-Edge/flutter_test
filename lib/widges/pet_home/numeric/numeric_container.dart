import 'package:flutter/material.dart';
import 'numeric_activity.dart';
import 'package:ff_stars/ff_stars.dart';
import 'package:percent_indicator/percent_indicator.dart';


/// 一级界面活力值板块
class MyGridViewContainer extends StatelessWidget {
  final double width;
  final double height;

  const MyGridViewContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      // padding: EdgeInsets.fromLTRB(width*0.1, top, width, width*0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 左侧标题
              Text(
                '爱宠今日活力值',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ZHUOKAI',
                  color: Colors.black87
                ),
              ),
              // 右侧箭头
             /* GestureDetector(
                onTap: () {
                  // 在这里添加跳转逻辑
                },
                child: const Row(
                  children: [
                    Text(
                      '去记录',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),*/
            ],
          ),
          SizedBox(height: 16), // 添加间距
          // 第二排
          Expanded(
            child: MyGridView(width: width,height: height*0.7, state: true,), // 调用显示 MyGridView 的部分
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

  const NumericContainer({
    Key? key,
    required this.width,
    required this.height,
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
            child: MyGridView(width: width,height: height*0.40,state: false,), // 调用显示 MyGridView 的部分
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