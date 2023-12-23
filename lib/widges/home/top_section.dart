import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TopSection extends StatelessWidget{
  final double section_width;
  final double section_height;

  const TopSection({Key? key, required this.section_width, required this.section_height}) : super(key: key);



  Container _LeftButton() {
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
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          // size（width，height）
          minimumSize: Size(section_width*0.47, section_height*0.9),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: Color(0XFF827397),
        ),

        child:const Padding(
          padding: EdgeInsets.only(top: 0, left: 0),
          child: Text(
            "快速问诊",
            style: TextStyle(
                fontFamily: "ZHUOKAI",
                fontWeight: FontWeight.w400,
                fontSize: 26,
                letterSpacing: 4.0,
                color: Colors.white
            ),
          ),
        ),

      ),
    );
  }

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
            minimumSize: Size(section_width*0.47, section_height*0.43),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: Color(0XFFC5BBD1),

        ),
        child: const Text(
          "AI辅助自查",
          style: TextStyle(
              fontFamily: "ZHUOKAI",
              fontWeight: FontWeight.w400,
              fontSize: 18,
              letterSpacing: 4.0,
            color: Colors.white
          ),),
      ),
    );
  }

  Container _Right_Down_Button() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // 阴影颜色及透明度
            offset: const Offset(2, 4), // 阴影偏移量，X轴为0，Y轴为10
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
            minimumSize: Size(section_width*0.47, section_height*0.43),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: Color(0XFFC5BBD1),
        ),

        child: const Text("找医院",
          style: TextStyle(
              fontFamily: "ZHUOKAI",
              fontWeight: FontWeight.w400,
              fontSize: 18,
              letterSpacing: 4.0,
              color: Colors.white
          ),),
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
          _LeftButton(),
          sizedBox_left(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Right_Up_Button(),
              _Right_Down_Button(),
            ],
          ),
        ],
      ),
    );

    }

}

