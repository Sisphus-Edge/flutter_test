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

class Profile {
  late String firstName;
  late String lastName;
  late String location;
  late int numberOfFollowers;
  late int numberFollowing;
  late int totalLikes;

  String get fullName => "$firstName $lastName";

  String get numberOfFollowersString => _abbreviatedCount(numberOfFollowers);

  String get numberFollowingString => _abbreviatedCount(numberFollowing);

  String get totalLikesString => _abbreviatedCount(totalLikes);

  String _abbreviatedCount(int num) {
    if (num < 1000) return "$num";
    if (num >= 1000 && num < 1000000) {
      String s = (num / 1000).toStringAsFixed(1);
      if (s.endsWith(".0")) {
        int idx = s.indexOf(".0");
        s = s.substring(0, idx);
      }
      return "${s}K";
    } else if (num >= 1000000 && num < 1000000000) {
      String s = (num / 1000000).toStringAsFixed(1);
      if (s.endsWith(".0")) {
        int idx = s.indexOf(".0");
        s = s.substring(0, idx);
      }
      return "${s}M";
    }
    return "";
  }
}


class PortalRoute extends StatefulWidget {
  @override
  _PortalRouteState createState() => _PortalRouteState();
}

class _PortalRouteState extends State<PortalRoute> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// tabbar指向哪一个界面 && appbar随之而改变
  int selectedPos = 0;
  late double bottomNavBarHeight = 60;
  late CircularBottomNavigationController _navigationController;

  /// tabbar能够指向的所有一级页面集合
  final List _routes= [
    HomeRoute(),
    PetHomeRoute(),
    CommunityRoute(),
    ProfileRoute(),
  ];


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
    double bottomNavBarHeight = MediaQuery.of(context).size.width * 0.15;
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
    else{
      return Scaffold(
        key: _scaffoldKey,
        // appBar:_appbar[selectedPos],
        // drawer: PortalDrawer(),
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
  }
///   onPressed: () => Navigator.of(context).pushNamed("login"),
  /// 调用结束后释放资源
  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}
