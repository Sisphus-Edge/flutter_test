import 'package:flutter/material.dart';


class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(

      // title: Text('Hello, PetHome!'),
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
