import 'package:flutter/material.dart';

import 'package:untitled/widges/pet_home/top_section_pethome.dart';
import 'package:untitled/widges/pet_home/canlendar_pet_home.dart';
import 'package:untitled/routes/test.dart';

class PetHomeRoute extends StatefulWidget {
  const PetHomeRoute({super.key,required this.MediaWidth, required this.MediaHeight});
  final double MediaWidth;
  final double MediaHeight;

  @override
  _PetHomeRouteState createState() => _PetHomeRouteState();

}

class _PetHomeRouteState extends State<PetHomeRoute> {

  late double sharedMediaWidth;
  late double sharedMediaHeight;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sharedMediaWidth = widget.MediaWidth;
    sharedMediaHeight = widget.MediaHeight;

    return Container(
      // color: Colors.grey,
      child: Container(
        // child: MyApp(),
        padding: EdgeInsets.symmetric(horizontal: sharedMediaWidth *0.03,vertical: sharedMediaHeight*0.015),
        child: Column(
            children: [
              FittedBox(
                fit: BoxFit.contain, // 限制子部件的大小，确保其不会超出容器的边界
                child: TopSection(section_width: sharedMediaWidth * 0.97, section_height: sharedMediaHeight*0.16), // 添加您想要显示的内容

              ),
              // sizeOf(hie),
              Divider(
                color: Colors.transparent,
                height: sharedMediaHeight * 0.01,
              ),
              Canlendar_petHome(section_width: sharedMediaWidth * 0.97, section_height: sharedMediaHeight*0.16),
              Divider(
                color: Colors.transparent,
                height: sharedMediaHeight * 0.02,
              ),

              // 仅供测试
              Container(
                width: sharedMediaWidth*0.85,
                height: sharedMediaHeight*0.44,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // 阴影颜色
                      spreadRadius: 5, // 阴影扩散程度
                      blurRadius: 7, // 阴影模糊程度
                      offset: Offset(0, 3), // 阴影偏移量
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15), // 圆角半径
                  child: Image.asset(
                    'assets/test/20.png',
                    // 图片高度
                    fit: BoxFit.cover, // 图片填充方式
                  ),
                ),
              )

            ]
        ),
      ),
    );  }
}


