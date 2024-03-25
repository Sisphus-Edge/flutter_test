import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
double globalItemHeight = 100; // 全局变量用于itemheight
// 第二排的height直接在DoubleLayerExpanded中实现

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
Widget buildCircularPercentIndicator(double radius){
  return CircularPercentIndicator(
    radius: radius,
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
Widget buildDateWidget(DateTime date){
  return  Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    alignment: Alignment.centerLeft,
    child: Text(
      '${date.year}-${date.month}-${date.day}',
      style: const TextStyle(
        fontSize: 20,
        fontFamily: 'ZHUOKAI',
      ),
      textAlign: TextAlign.left,
    ),
  );
}

