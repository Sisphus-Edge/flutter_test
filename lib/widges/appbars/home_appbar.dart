import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: Text(
              '你好，火锅配油碟！',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'ZHUOKAI',
                fontSize: 20,
                letterSpacing: 2.0,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // 处理消息提醒按钮点击事件
            },
          ),
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar/avatar1.jpg'), // 更换为你的头像图片路径
            ),
            onPressed: () {
              // 处理头像按钮点击事件
              // NavigationBar
            },
          ),
        ],
      ),

    );
  }
}
