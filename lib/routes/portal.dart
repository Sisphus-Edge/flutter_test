
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/routes/home.dart';

import 'community.dart';
import 'pet_home.dart';
import 'profile.dart';

import 'package:untitled/widges/portal_drawer.dart';
import 'package:untitled/widges/bottom_tab_bar.dart';

/// appbar系列
import 'package:untitled/widges/appbars/home_appbar.dart';
import 'package:untitled/widges/appbars/pethome_appbar.dart';
import 'package:untitled/widges/appbars/community_appbar.dart';
import 'package:untitled/widges/appbars/profile_appbar.dart';

class PortalRoute extends StatefulWidget {
  const PortalRoute({super.key});

  @override
  _PortalRouteState createState() => _PortalRouteState();
}

class _PortalRouteState extends State<PortalRoute> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 设备的长宽
  late double MediaWidth;
  late double MediaHeight;

  /// tabbar指向哪一个界面 && appbar随之而改变
  int selectedPos = 0;
  late CircularBottomNavigationController _navigationController;


  /// appbar集合
  final List _appbar = [
    HomeAppBar(),
    PetHomeAppBar(),
    CommunityAppBar(),
    ProfileAppBar(),
  ];

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);

  }

  @override
  Widget build(BuildContext context) {
    MediaWidth = MediaQuery.of(context).size.width ?? 393;
    MediaHeight = MediaQuery.of(context).size.height ?? 808;
    double bottomNavBarHeight = MediaHeight * 0.08;
    // bottomNavBarHeight = MediaHeight * 0.2 ;

    /// tabbar能够指向的所有一级页面集合
    final List _routes= [
      HomeRoute(MediaWidth: MediaWidth, MediaHeight: MediaHeight,),
      PetHomeRoute(),
      CommunityRoute(),
      ProfileRoute(),
    ];

    if(selectedPos != 3){
      return Scaffold(
        key: _scaffoldKey,
        appBar:_appbar[selectedPos],
        drawer: PortalDrawer(),
        // body: const Center(
        //   child: Text('Main Content Here'),
        // ),
        body: _routes[selectedPos],
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
    /// 如果是profile页面，则没有appbar
    else{
      return Scaffold(
        key: _scaffoldKey,
        body: _routes[selectedPos],
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
  }
///   onPressed: () => Navigator.of(context).pushNamed("login"),
  /// 调用结束后释放资源
  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}
