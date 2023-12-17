import 'package:flutter/material.dart';

import '../widges/profile_header/profile_header.dart';


class ProfileRoute extends StatefulWidget {
  const ProfileRoute({Key? key}) : super(key: key);

  @override
  _ProfileRouteState createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 700.0),
      child: ListView(
        // padding: const EdgeInsets.only(left: 5.0),
        children: <Widget>[
          ProfileHeader(),
          _buildListItem("Personal Information", Icons.person_outlined, () {}),
          _buildListItem("Appointment Memories", Icons.camera, () {}),
          _buildListItem("Self Inspection Records", Icons.search_rounded, () {}),
          _buildListItem("Favourites", Icons.favorite_border_outlined, () {}),
          _buildListItem("Presents", Icons.card_giftcard, () {}),
          _buildListItem("Recommend Us", Icons.workspace_premium, () {}),
        ],
      ),
    );
  }

  Widget _buildListItem(String title, IconData iconData, VoidCallback action) {
    const textStyle = TextStyle(
        color: Colors.black54, fontSize: 18.0, fontWeight: FontWeight.w400);

    return InkWell(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
        /// 每一行
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// 左侧表示icon
            Container(
              width: 30.0,
              height: 30.0,
              margin: const EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                // color: Colors.purple,
                borderRadius: BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: Icon(
                  iconData,
                  color: const Color(0xFFE6B653),
                  // color: const Color(0xFF2e1461),
                  size: 24.0
              ),
            ),
            /// 文字
            Text(title, style: textStyle),
            /// 间隔
            Expanded(child: Container()),
            /// 右侧指向符
            IconButton(
              icon: const Icon(Icons.chevron_right, color: Colors.black26),
              onPressed: action,
            ),
          ],
        ),
      ),
    );
  }
}
