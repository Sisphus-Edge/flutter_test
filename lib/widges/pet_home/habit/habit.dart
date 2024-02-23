import 'package:flutter/material.dart';

class ContainerWithWeekGridView extends StatelessWidget {
  final double width;
  final double height;

  const ContainerWithWeekGridView({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 第一排
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 左侧标题
                Text(
                  '标题',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // 右侧箭头
                GestureDetector(
                  onTap: () {
                    // 在这里添加跳转逻辑
                  },
                  child: Row(
                    children: [
                      Text(
                        '查看更多',
                        style: TextStyle(
                          fontSize: 12,
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
                ),
              ],
            ),
          ),
          SizedBox(height: 16), // 添加间距
          // 第二排调用显示 WeekGridView
          WeekGridView(),
        ],
      ),
    );
  }
}

// WeekGridView 的定义
class WeekGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 1; i <= 7; i++)
          Expanded(
            child: Column(
              children: [
                // 星期几
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  color: Colors.grey[200],
                  child: Text(
                    '星期$i',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // 正方形
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Colors.blue, // 演示用蓝色
                ),
              ],
            ),
          ),
      ],
    );
  }
}
