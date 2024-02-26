
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/routes/first_level_page/home.dart';

import 'first_level_page/community.dart';
import 'first_level_page/pet_home.dart';
import 'first_level_page/profile.dart';

import 'package:untitled/widges/portal_drawer.dart';
import 'package:untitled/widges/bottom_tab_bar.dart';

/// appbar系列
import 'package:untitled/widges/appbars/home_appbar.dart';
import 'package:untitled/widges/appbars/pethome_appbar.dart';
import 'package:untitled/widges/appbars/community_appbar.dart';
import 'package:untitled/widges/appbars/profile_appbar.dart';
//引入UserInfo进行数据传递
import 'package:untitled/db/UserDB/UserInfo.dart';

class PortalRoute extends StatefulWidget {
  final UserInfo userInfo; // 假设UserInfo是存储用户信息的类

  const PortalRoute({Key? key, required this.userInfo}) : super(key: key);

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
    MediaHeight = MediaQuery.of(context).size.height*0.92 ?? 808;
    /// body & buttonbar采取stack布置，需要严格控制整体界面的大小’
    /// MediaWidth &MediaHeight 的适用范围体现在：
    /// 调用一级界面时传参
    double bottomNavBarHeight = MediaHeight * 0.08;
    /// 顶部的距离
    final topPadding = MediaQuery.of(context).padding.top;
    // bottomNavBarHeight = MediaHeight * 0.2 ;

    // 使用widget.userInfo访问传入的用户信息
    final UserInfo = widget.userInfo;
    /// tabbar能够指向的所有一级页面集合
    final List _routes= [
      HomeRoute(MediaWidth: MediaWidth, MediaHeight: MediaHeight,),
      PetHomeRoute(MediaWidth: MediaWidth, MediaHeight: MediaHeight,),
      CommunityRoute(topPadding:topPadding, MediaWidth: MediaWidth, MediaHeight: MediaHeight,),
      ProfileRoute(userInfo: UserInfo),
    ];

    if(selectedPos != 3){
      return Scaffold(
        key: _scaffoldKey,
        appBar:_appbar[selectedPos],
        /// stack添加之前的代码，由于是cicularbutton，很大一部分用不了
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
