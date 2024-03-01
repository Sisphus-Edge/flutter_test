import 'package:flutter/material.dart';

import 'package:untitled/widges/pet_home/top_section_pethome.dart';
import 'package:untitled/widges/pet_home/canlendar_pet_home.dart';
import 'package:untitled/widges/pet_home/numeric/numeric_container.dart';
import 'package:untitled/widges/pet_home/habit/habit.dart';
import 'package:untitled/widges/pet_home/habit/habit_container.dart';
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
                height: sharedMediaHeight * 0.01,
              ),
              // MyGridView(width: sharedMediaWidth * 0.97, height: sharedMediaHeight*0.25),
              // 到此 width剩下0.0445
              /// 爱宠今日活力值
              MyGridViewContainer(width: sharedMediaWidth * 0.97, height: sharedMediaHeight*0.3),
              Divider(
                color: Colors.transparent,
                height: sharedMediaHeight * 0.015,
              ),
              /// 每周习惯完成情况
              ContainerWithWeekGridView(width: sharedMediaWidth*0.97, height: sharedMediaHeight*0.144,
              identifier: [false,false,true,true,true,false,true],
              )
              // MyHomePage(),
              // 仅供测试
            ]
        ),
      ),
    );  }
}


