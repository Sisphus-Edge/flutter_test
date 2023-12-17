import 'package:flutter/material.dart';
import 'profile_header_style.dart';
import 'profile.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key});


  // final Profile profile;

  // ProfileHeader(this.profile);
  final profile = getProfile();

  @override
  Widget build(BuildContext context) {

    final topPadding = MediaQuery
        .of(context)
        .padding
        .top;

   /* const headerGradient = RadialGradient(
      center: Alignment.topLeft,
      radius: 0.4,
      colors: <Color>[
        // Color(0xFF8860EB),
        Color(0xFFDFBE96),
        // Color(0xFF8881EB),
        Color(0xFFDFBE96),

      ],
      stops: <double>[
        0.4, 1.0,
      ],
      tileMode: TileMode.repeated,
    );*/


    const headerHeight = 280.0;

    return Container(
      height: headerHeight,
      decoration: BoxDecoration(
        color: ProfileColors.primaryColor,
        /// header的阴影
        boxShadow: const <BoxShadow>[
          BoxShadow(
              spreadRadius: 4.0,
              blurRadius: 6.0, /// 渲染范围
              offset: Offset(0.0, 1.0), /// 偏移
              color: Colors.black38),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // linear gradient
          Container(
            height: headerHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                /// 线性渐变
                  colors: <Color>[ //7928D1
                    // Color(0xFF7928D1),
                    // Color(0xFF9A4DFF)
                    // Colors.amber,
                    Color(0xFF8250DF), // 右上
                    Color(0xFF6639BA), // 左下
                  ],
                  stops: <double>[0.2, 0.6],
                  begin: Alignment.topRight, end: Alignment.bottomLeft
              ),
            ),
          ),
          // radial gradient
          CustomPaint(
            painter: HeaderGradientPainter(),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: topPadding, left: 15.0, right: 15.0, bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildBellIcon(),
                /// title profile
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: _buildTitle(),
                ),
                /// 头像 & 信息
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: _buildAvatar(),
                ),
                /// followers
                _buildFollowerStats()
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build the bell icon at the top right corner of the header
  Widget _buildBellIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IconButton(
            icon: const Icon(
              LineAwesomeIcons.bell, color: Colors.white, size: 30.0,),
            onPressed: () {}),
      ],
    );
  }

  /// 账户标题
  Widget _buildTitle() {
    return Text("Profile",
        style: TextStyle(
            fontFamily: ProfileFontNames.TimeBurner,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 34.0,
            letterSpacing: 1.0));
  }

  /// The avatar consists of the profile image, the users name and location
  /// 头像 用户名 地址
  Widget _buildAvatar() {
    /// 用户名style
    final mainTextStyle = TextStyle(fontFamily: ProfileFontNames.TimeBurner,
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 20.0);
    /// 地址style
    final subTextStyle = TextStyle(
        fontFamily: ProfileFontNames.TimeBurner,
        fontSize: 16.0,
        color: Colors.white70,
        fontWeight: FontWeight.w700);

    return Row(
      children: <Widget>[
        Container(
          width: 70.0, height: 60.0,
          decoration: BoxDecoration(
            // image: const DecorationImage(
            //     image: AssetImage("assets/images/emma-watson.jpg"),
            //     fit: BoxFit.cover),
            borderRadius: BorderRadius.all(new Radius.circular(20.0)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colors.black26, blurRadius: 5.0, spreadRadius: 1.0),
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.only(right: 20.0)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(profile.fullName, style: mainTextStyle),
            Text(profile.location, style: subTextStyle),
          ],
        ),
      ],
    );
  }

  /// 关注的排列
  Widget _buildFollowerStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildFollowerStat("Followers", profile.numberOfFollowersString),
        _buildVerticalDivider(),
        _buildFollowerStat("Following", profile.numberFollowingString),
        _buildVerticalDivider(),
        _buildFollowerStat("Total Likes", profile.totalLikesString),
      ],
    );
  }

  /// 单个关注
  Widget _buildFollowerStat(String title, String value) {
    /// 第一行
    final titleStyle = TextStyle(
        fontSize: 16.0,
        fontFamily: ProfileFontNames.TimeBurner,
        color: Colors.white);
    /// 第二行
    final valueStyle = TextStyle(
        fontFamily: ProfileFontNames.TimeBurner,
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.white);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(title, style: titleStyle),
        Text(value, style: valueStyle),
      ],
    );
  }

  /// 关注栏的分隔符
  Widget _buildVerticalDivider() {
    return Container(
      height: 30.0,
      width: 2.0,
      color: Colors.white30,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}

class HeaderGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: paint background radial gradient
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}
