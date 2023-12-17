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


    // return Text("Home");
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: [
    //     TopSection(section_width: sharedMediaWidth * 0.9, section_height: sharedMediaHeight*0.3),
    //     ScrollableButtons(),
    //     AppointmentsSection(),
    //     TweetsSection(),
    //   ],
    // );

    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: sharedMediaWidth *0.03,vertical: sharedMediaHeight*0.02),
        child: Column(
          /// 0.02
          /// part 1: 0.2
          /// part 2： 0.15
          /// 0.2
          /// section的内边距： 0.3（section_为比例）
          children: [
            FittedBox(
              fit: BoxFit.contain, // 限制子部件的大小，确保其不会超出容器的边界
              child: TopSection(section_width: sharedMediaWidth * 0.97, section_height: sharedMediaHeight*0.2), // 添加您想要显示的内容
            ),
            // sizeOf(hie),
            // ScrollableButtons(section_width: sharedMediaWidth * 0.97, section_height: sharedMediaHeight*0.1),
          ],
        )
      ),
    );
  }
}


