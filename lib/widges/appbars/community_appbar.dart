import 'package:flutter/material.dart';

class CommunityAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
      '逛逛社区',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontFamily: 'ZHUOKAI',
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
        letterSpacing: 5.0,
      ),
    ),

    );
  }

}
