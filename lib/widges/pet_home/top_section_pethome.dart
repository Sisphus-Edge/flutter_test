import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'daily.dart';

class TopSection extends StatelessWidget{
  final double section_width;
  final double section_height;

  const TopSection({Key? key, required this.section_width, required this.section_height}) : super(key: key);



  Container _LeftButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // 阴影颜色及透明度
            offset: Offset(2, 4), // 阴影偏移量，X轴为0，Y轴为10
            blurRadius: 2, // 阴影模糊半径
            // spreadRadius: 0, // 阴影扩散半径
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DailyPage(date: DateTime.now(),)), // 导航到 DailyPage 页面
          );
        },
        style: ElevatedButton.styleFrom(
          // size（width，height）
          minimumSize: Size(section_width*0.56, section_height*0.9),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

        ),
        child: const Text(
          '每日记录',
          // style: GoogleFonts.zcoolXiaoWei(fontSize: 22),
          style: TextStyle(
            fontFamily: 'ZCOOL',
            fontSize: 22,
          ),
        ),
      ),
    );
  }
  /// 卡通形象button
  Container _Right_Up_Button() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // 阴影颜色及透明度
            offset: const Offset(2, 2), // 阴影偏移量，X轴为0，Y轴为10
            blurRadius: 2, // 阴影模糊半径
            // spreadRadius: 0, // 阴影扩散半径
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          // size（width，height）
            minimumSize: Size(section_width*0.36, section_height*0.9),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
        ),
        child: Text(
          '卡通形象',
          style: TextStyle(
            fontFamily: 'ZCOOL',
            fontSize: 22,
          ),
        ),

      ),
    );
  }


  SizedBox sizedBox_left(){
    return SizedBox(width: section_width * 0.02,);
  }

  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Container(
      // color: Colors.greenAccent,
      /// 宽度 0.03 || 0.47 || 0.02 || 0.47 ||0.0 == 1.0
      /// 高度  0.05 || 0.9 ||0.05  右边 ： 0.05 ||0.43 | 0.04 |0.43 ||0.05
      padding:  EdgeInsets.symmetric(vertical: section_height*0.05, horizontal: section_width*0.02),// (垂直，水平)
      width: section_width, // 设置容器的宽度为 300
      height: section_height,
      // color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _LeftButton(context),
          sizedBox_left(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Right_Up_Button(),
            ],
          ),
        ],
      ),
    );

  }

}

