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
    TabItem(
      Icons.home,
      "Home",
      Colors.blue,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
    ),
    TabItem(
      Icons.search,
      "Search",
      Colors.orange,
      labelStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    TabItem(
      Icons.layers,
      "Reports",
      Colors.red,
      circleStrokeColor: Colors.black,
    ),
    TabItem(
      Icons.notifications,
      "Notifications",
      Colors.cyan,
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
