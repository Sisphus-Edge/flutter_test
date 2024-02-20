import 'package:flutter/material.dart';
import 'disease_library/disease_library_screen.dart';
import 'medicine_library/medicine_library_screen.dart';
class ScrollableButtons extends StatelessWidget {
  const ScrollableButtons({super.key, required this.section_width, required this.section_height});
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
              '其他功能', // 左对齐的单词
              textAlign: TextAlign.left, // 设置为左对齐
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
                fontFamily: "ZHUOKAI",
                letterSpacing: 2.0,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // 右对齐文本的点击处理逻辑，跳转等
            },
            child: const Text(
              '更多', // 右对齐的单词
              textAlign: TextAlign.right, // 设置为右对齐
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
                letterSpacing: 2.0,
                fontFamily: "ZHUOKAI",
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 可滑动button的模板

  Container _buildScrolloableButton(String text, Color color, IconData iconData, VoidCallback onPressed, double buttonWidth, double buttonHeight, BuildContext context)
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
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
        ),
        child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData,color: Color(0XFF827397),), // 显示图标
          const SizedBox(width: 8), // 间距
          Text(
            text, // 显示文本
            style: const TextStyle(
              fontSize: 13,
              fontFamily: "ZHUOKAI",
              letterSpacing: 1.0,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ), // 文本样式

          ),
        ],
      ),
      ),
    );
    
  }


  Container buttons(double buttonWidth,double buttonHeight, BuildContext context){
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      // color: Colors.blue,
      child: ListView(
        scrollDirection: Axis.horizontal,
      children: <Widget>[
        _buildScrolloableButton(
            '药品库',
            Colors.orange,
            Icons.medication,
                () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MedicineLibraryScreen(),
              ));
            },
            buttonWidth * 0.38,
            buttonHeight,
            context
        ),

        const SizedBox(width: 10.0,),
        _buildScrolloableButton(
            '疾病库',
            Colors.orange,
            Icons.medical_information,
                () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DiseaseLibraryScreen(),
              ));
            },
            buttonWidth * 0.38,
            buttonHeight,
            context
        ),
        const SizedBox(width: 10.0,),
        _buildScrolloableButton('疫苗预约',
            Colors.orange, Icons.pin_invoke, () { },
            buttonWidth*0.38,
            buttonHeight,
            context
        ),
        // const SizedBox(width: 10.0,),
        // _buildScrolloableButton('text',
        //     Colors.orange, Icons.abc, () { },
        //     buttonWidth*0.33,buttonHeight),
      ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      // color: Colors.blue,
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
          buttons(section_width,section_height*0.5,context)
        ],
      ),
    );
  }

}
