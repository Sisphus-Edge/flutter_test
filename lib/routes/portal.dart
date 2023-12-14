import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter/material.dart';

import 'community.dart';

import 'package:untitled/widges/bottom_tab_bar.dart';
import 'package:untitled/widges/portal_drawer.dart';
import 'package:untitled/widges/portal_appbar.dart';

class PortalRoute extends StatefulWidget {
  @override
  _PortalRouteState createState() => _PortalRouteState();
}

class _PortalRouteState extends State<PortalRoute> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// tabbar指向哪一个界面
  int selectedPos = 0;
  late double bottomNavBarHeight = 60;
  late CircularBottomNavigationController _navigationController;

  /// tabbar能够指向的所有一级页面集合
  final List<Widget> _routes = [
    PortalRoute(),
    CommunityRoute(),
  ];

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: PortalAppBar(),
      drawer: PortalDrawer(),
      // body: IndexedStack(
      //   index: _currentIndex,
      //   children: _routes,
      // ),
      body: const Center(
        child: Text('Main Content Here'),
      ),
      bottomNavigationBar: BottomTabBar(
        navigationController: _navigationController,
        selectedPos: selectedPos,
        bottomNavBarHeight: bottomNavBarHeight,
        selectedCallback: (int? selectedPos) {
          setState(() {
            this.selectedPos = selectedPos ?? 0;
          });
        },
      ),
    );
  }

  /// 调用结束后释放资源
  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}


