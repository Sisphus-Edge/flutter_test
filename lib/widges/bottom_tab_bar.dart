import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

class BottomTabBar extends StatelessWidget {
  late final CircularBottomNavigationController navigationController;
  late final int selectedPos;
  late final double bottomNavBarHeight;
  late final Function(int?) selectedCallback;

  BottomTabBar({super.key,
    required this.navigationController,
    required this.selectedPos,
    required this.bottomNavBarHeight,
    required this.selectedCallback,
  });

  List<TabItem> tabItems = List.of([
    /// 第一个 home
    TabItem(
      Icons.home,
      "首页",
      // Color(0xFF827397),
      // Color(0xFFDFBE96),
      // Color(0xFFCCD8D0),
      const Color(0xFFE6B653),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xFF24271E),
        fontFamily: 'ZCOOL',
        fontSize: 16
      ),

    ),
    /// 第二个 我的小狗
    TabItem(
      Icons.pets,
      "我的小狗",
      const Color(0xFFE6B653),
      labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF24271E),
          fontFamily: 'ZCOOL',
          fontSize: 16
      ),
    ),
    /// 第三个 社区
    TabItem(
      // Icons.landscape,
      Icons.public,
      "社区",
      const Color(0xFFE6B653),
      // circleStrokeColor: Colors.black,
      labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF24271E),
          fontFamily: 'ZCOOL',
          fontSize: 16
      ),
    ),
    /// 第四个 账户
    TabItem(
      Icons.person,
      "账户",
      const Color(0xFFE6B653),
      labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF24271E),
          fontFamily: 'ZCOOL',
          fontSize: 16
      ),
    ),
  ]);
  @override
  Widget build(BuildContext context) {
    return CircularBottomNavigation(
      tabItems,
      controller: navigationController,
      selectedPos: selectedPos,
      barHeight: bottomNavBarHeight,
      // Other properties...
      selectedCallback: selectedCallback,
    );
  }

}
