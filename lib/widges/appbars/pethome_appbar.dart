import 'package:flutter/material.dart';

class PetHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        '我的爱宠',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: 'ZHUOKAI',
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
          letterSpacing: 5.0,
        ),
      ),
      // actions: [
      // IconButton(
      //   icon: Icon(Icons.menu),
      //   onPressed: () {
      //     Scaffold.of(context).openDrawer();
      //   },
      // ),
      // ],
    );
  }
}
