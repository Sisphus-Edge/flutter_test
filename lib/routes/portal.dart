import 'package:flutter/material.dart';

import 'profile.dart';
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
  int _currentIndex = 0;

  /// tabbar能够指向的所有一级页面集合
  final List<Widget> _routes = [
    PortalRoute(),
    CommunityRoute(),
  ];


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
      body: Center(
        child: Text('Main Content Here'),
      ),
      bottomNavigationBar: BottomTabBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      )
    );
  }
}


