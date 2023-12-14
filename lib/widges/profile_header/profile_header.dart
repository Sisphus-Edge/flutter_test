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

    const headerGradient = RadialGradient(
      center: Alignment.topLeft,
      radius: 0.4,
      colors: <Color>[
        Color(0xFF8860EB),
        Color(0xFF8881EB),
      ],
      stops: <double>[
        0.4, 1.0,
      ],
      tileMode: TileMode.repeated,
    );

    const headerHeight = 290.0;

    return Container(
      height: headerHeight,
      decoration: BoxDecoration(
        color: ProfileColors.primaryColor,
        boxShadow: <BoxShadow>[
          BoxShadow(spreadRadius: 2.0,
              blurRadius: 4.0,
              offset: new Offset(0.0, 1.0),
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
                  colors: <Color>[ //7928D1
                    Color(0xFF7928D1), Color(0xFF9A4DFF)],
                  stops: <double>[0.3, 0.5],
                  begin: Alignment.topRight, end: Alignment.bottomLeft
              ),
            ),
          ),
          // radial gradient
          CustomPaint(
            painter: new HeaderGradientPainter(),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: topPadding, left: 15.0, right: 15.0, bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildBellIcon(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: _buildTitle(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: _buildAvatar(),
                ),
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
            icon: Icon(
              LineAwesomeIcons.bell, color: Colors.white, size: 30.0,),
            onPressed: () {}),
      ],
    );
  }

  Widget _buildTitle() {
    return Text("Profile",
        style: TextStyle(
            fontFamily: ProfileFontNames.TimeBurner,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 40.0,
            letterSpacing: 1.0));
  }

  /// The avatar consists of the profile image, the users name and location
  Widget _buildAvatar() {
    final mainTextStyle = TextStyle(fontFamily: ProfileFontNames.TimeBurner,
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 20.0);
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

  Widget _buildFollowerStat(String title, String value) {
    final titleStyle = TextStyle(
        fontSize: 16.0,
        fontFamily: ProfileFontNames.TimeBurner,
        color: Colors.white);
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

  Widget _buildVerticalDivider() {
    return Container(
      height: 30.0,
      width: 1.0,
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
