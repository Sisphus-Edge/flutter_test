import 'package:flutter/material.dart';

class PortalAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Hello, Sisphus-Edge!'),
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
