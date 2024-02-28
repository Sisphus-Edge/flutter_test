import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:untitled/widges/home/appointments_section.dart';
import 'package:untitled/widges/home/scrollable_buttons.dart';
import 'package:untitled/widges/home/top_section.dart';
import 'package:untitled/widges/home/tweets_section.dart';

/// 一个总padding
/// 传递给每个child的padding不用考虑边框

class HomeRoute extends StatefulWidget {

  final double MediaWidth;
  final double MediaHeight;

  const HomeRoute({Key? key, required this.MediaWidth, required this.MediaHeight}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();

}

class _HomeRouteState extends State<HomeRoute> {

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
        padding: EdgeInsets.symmetric(horizontal: sharedMediaWidth *0.03,vertical: sharedMediaHeight*0.015),
        child: ListView(
          /// 0.02
          /// part 1: 0.25
          /// driver: 0.015
          /// part 2： 0.13
          /// driver: 0.015
          /// part 3: 0.185
          /// driver: 0.015
          /// part 4: 0.38
          /// 余下 ： 0.02
          /// 0.02
          /// section的内边距  在此处定义 0.3（section_为比例）
          ///
          children: [
            FittedBox(
              fit: BoxFit.contain, // 限制子部件的大小，确保其不会超出容器的边界
              child: TopSection(section_width: sharedMediaWidth * 0.97, section_height: sharedMediaHeight*0.24), // 添加您想要显示的内容
            ),
            // sizeOf(hie),
            Divider(
              color: Colors.transparent,
              height: sharedMediaHeight * 0.01,
            ),
            FittedBox(
              fit: BoxFit.contain, // 限制子部件的大小，确保其不会超出容器的边界
              child: ScrollableButtons(section_width: sharedMediaWidth * 0.97, section_height: sharedMediaHeight*0.12),
            ),
            Divider(
              color: Colors.transparent,
              height: sharedMediaHeight * 0.01,
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: AppointmentsSection(section_width: sharedMediaWidth * 0.97, section_height: sharedMediaHeight*0.16),
            ),
            Divider(
              color: Colors.transparent,
              height: sharedMediaHeight * 0.01,
            ),
            FittedBox(
              fit: BoxFit.contain,

              child: TCardSecton(section_width: sharedMediaWidth * 0.97, section_height: sharedMediaHeight*0.29),
            ),
          ],
        )
      ),
    );
  }
}


