import 'package:flutter/material.dart';
import 'numeric_activity.dart';

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
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 16),
            // height: height*0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 左侧标题
                const Text(
                  '爱宠今日活力值',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ZHUOKAI',
                    color: Colors.black87
                  ),
                ),
                // 右侧箭头
                GestureDetector(
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
                ),
              ],
            ),
          ),
          SizedBox(height: 16), // 添加间距
          // 第二排
          Expanded(
            child: MyGridView(width: width,height: height*0.7), // 调用显示 MyGridView 的部分
          ),
        ],
      ),
    );
  }
}
