import 'package:flutter/material.dart';

class PortalDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Drawer Header',
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item'),
            onTap: () {
              // TODO: Handle drawer item tap
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // TODO: Handle drawer item tap
            },
          ),
        ],
      ),
    );
  }
}
