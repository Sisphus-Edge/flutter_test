import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ScrollableButtons extends StatelessWidget {
  const ScrollableButtons({super.key, required this.section_width, required this.section_height});
  final double section_width;
  final double section_height;

  /// 可滑动button的模板
  Widget _buildScrolloableButton(String text, Color color, IconData iconData, VoidCallback onPressed,double buttonWidth,double buttonHeight)
  {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(buttonWidth, buttonHeight), // 设置按钮的最小尺寸
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData), // 显示图标
          const SizedBox(width: 8), // 间距
          Text(
            text, // 显示文本
            style: const TextStyle(fontSize: 10), // 文本样式
          ),
        ],
      ),
    );
  }


  Container title(double textWidth,double textHeight){
    return Container(
      color: Colors.purple,
      width: textWidth,
      height: textHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: const Text(
              'Other Function', // 左对齐的单词
              textAlign: TextAlign.left, // 设置为左对齐
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // 右对齐文本的点击处理逻辑，跳转等
            },
            child: const Text(
              'more', // 右对齐的单词
              textAlign: TextAlign.right, // 设置为右对齐
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width:  section_width,
      height: section_height,
      padding:  EdgeInsets.symmetric(vertical: section_height*0.05, horizontal: section_width*0.02),// (垂直，水平)
      child: Column(
        children: [
          title(section_width,section_height*0.3),
          ListView(
            children: <Widget>[
              _buildScrolloableButton('text', Colors.black54, Icons.abc, () { },section_width,section_height*0.7),
            ],
          ),
        ],
      ),
    );
  }

}
