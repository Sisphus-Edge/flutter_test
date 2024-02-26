import 'package:flutter/material.dart';
import 'package:untitled/db/UserDB/UserInfo.dart';
import 'package:untitled/widges/profile_header/edit_profile_route.dart';
class ProfileHeader extends StatefulWidget {
  final UserInfo initialUserInfo;

  const ProfileHeader({Key? key, required this.initialUserInfo}) : super(key: key);

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  late UserInfo userInfo;
  @override
  void initState() {
    super.initState();
    // 初始化时，将widget传入的用户信息赋值给本地变量
    userInfo = widget.initialUserInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF8250DF), // 紫色背景
      padding: EdgeInsets.all(16), // 内边距
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 头像
              CircleAvatar(
                backgroundImage: AssetImage(userInfo.avatar), // 使用AssetImage加载本地资源
                radius: 40,
              ),
              SizedBox(width: 16), // 头像与文字之间的间隔
              // 名字和地址
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      userInfo.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'ZHUOKAI',
                        letterSpacing: 4.0,
                      )
                  ),
                  Text(
                      userInfo.address,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'ZHUOKAI',
                        letterSpacing: 4.0,
                      )
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16), // 名字地址与按钮之间的间隔
          // 编辑资料按钮
          ElevatedButton(
            onPressed: () async {
              final updatedUserInfo = await Navigator.push<UserInfo>(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileRoute(userInfo: userInfo),
                ),
              );
              if (updatedUserInfo != null) {
                // 使用setState更新ProfileHeader的用户信息
                setState(() {
                  userInfo = updatedUserInfo;
                });
              }
            },
            child: Text('编辑资料',style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              fontFamily: 'ZHUOKAI',
              letterSpacing: 4.0,
            )),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple[300], // 按钮颜色
            ),
          ),
        ],
      ),
    );
  }
}
