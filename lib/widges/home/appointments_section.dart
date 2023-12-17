import 'package:flutter/material.dart';

class AppointmentsSection extends StatelessWidget {
  const AppointmentsSection({super.key, required this.section_width, required this.section_height});
  final double section_width;
  final double section_height;

  Container title(double textWidth,double textHeight){
    return Container(
      // color: Colors.purple,/// 调试
      width: textWidth,
      height: textHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: const Text(
              'AppointmentsSection', // 左对齐的单词
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

  /// 可滑动button的模板
  Container _buildScrolloableButton(String text,double buttonWidth, double buttonHeight)
  {
    return Container(
      padding: const EdgeInsets.only(bottom: 2.0),
      width: buttonWidth,
      // height: buttonHeight * 0.2,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // 阴影颜色及透明度
            offset: const Offset(2, 1), // 阴影偏移量(X轴，Y轴)
            blurRadius: 2, // 阴影模糊半径
            // spreadRadius: 0, // 阴影扩散半径
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
        ),
        child:Column(
          /// 0.45
          /// 0.1
          /// 0.45
          children: [
            Container(
              height: buttonHeight*0.45,
              color: Colors.blueGrey,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 8), // 间距
                  Text(
                    text, // 显示文本
                    style: const TextStyle(fontSize: 10), // 文本样式
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.transparent,
              height: buttonHeight * 0.05,
            ),
            Container(
              height: buttonHeight*0.45,
              color: Colors.black26,
              child:  Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 8), // 间距
                  Text(
                    text, // 显示文本
                    style: const TextStyle(fontSize: 10), // 文本样式
                  ),
                ],
              ),
            ),


          ],

        )
      ),
    );

  }


  Container buttons(double buttonWidth,double buttonHeight){
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      // color: Colors.blue,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _buildScrolloableButton('text',
              buttonWidth*0.85,buttonHeight),
          const SizedBox(width: 10.0,),
          _buildScrolloableButton('text',
              buttonWidth*0.85,buttonHeight),
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
      padding:  EdgeInsets.symmetric(vertical: section_height*0.075, horizontal: section_width*0.02),// (垂直，水平)
      child: Column(
        children: [
          title(section_width,section_height*0.3),
          // ListView(
          //   children: <Widget>[
          //     _buildScrolloableButton('text', Colors.black54, Icons.abc, () { },section_width,section_height*0.7),
          //   ],
          // ),
          SizedBox(height: section_height*0.05,),
          buttons(section_width,section_height*0.5)
        ],
      ),
    );
  }
}
