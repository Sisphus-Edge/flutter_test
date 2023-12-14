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
      "Home",
      // Color(0xFF827397),
      // Color(0xFFDFBE96),
      // Color(0xFFCCD8D0),
      const Color(0xFFE6B653),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xFF24271E),
      ),
    ),
    /// 第二个 我的小狗
    TabItem(
      Icons.pets,
      "Pet Home",
      const Color(0xFFE6B653),
      labelStyle: const TextStyle(
        color: Color(0xFF24271E),
        fontWeight: FontWeight.w600,
      ),
    ),
    /// 第三个 社区
    TabItem(
      // Icons.landscape,
      Icons.public,
      "Community",
      const Color(0xFFE6B653),
      // circleStrokeColor: Colors.black,
      labelStyle: const TextStyle(
        color: Color(0xFF24271E),
        fontWeight: FontWeight.w600,
      ),
    ),
    /// 第四个 账户
    TabItem(
      Icons.person,
      "Profile",
      const Color(0xFFE6B653),
      labelStyle: const TextStyle(
        color: Color(0xFF24271E),
        fontWeight: FontWeight.w600,
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
