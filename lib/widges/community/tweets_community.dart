import 'package:flutter/material.dart';

import 'tweets_section_button.dart';

class Tweets extends StatelessWidget {
  final double section_width;
  final double section_height;
  final List<String> sectionTitles;
  final List<Function()> onTapHandlers;

  Tweets({required this.sectionTitles, required this.section_width, required this.section_height, required this.onTapHandlers});

  @override
  Widget build(BuildContext context) {
    List<String> displayedAvatars =
    sectionTitles.length > 5 ? sectionTitles.sublist(0, 5) : sectionTitles;

    return Container(
      // height: section_height,
      // width: section_width*0.97,
      // color: Colors.black54,
      color: Colors.transparent,
      child: Column(
        children: [
          _buildTitle('Tweets'),
          // Divider(
          //   color: Colors.transparent,
          //   // height: section_height *,
          // ),
          Container(
            height: section_height*0.6,
            // height: section_height,
            width: section_width *0.9,
            // color: Colors.black87,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: displayedAvatars.length + 1, // 头像数量+1(用于“更多”按钮)
              itemBuilder: (BuildContext context, int index) {
                if (index == 5 && sectionTitles.length > 5) {
                  return _buildMoreButton(context);
                }
                return _buildAvatar(sectionTitles[index],index);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitle(String titleText) {
    return Container(
      height: section_height*0.36,
      width: section_width * 0.9,
      // color: Colors.yellowAccent,
      child: Text(
        titleText,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 25, // 标题字体大小
          fontWeight: FontWeight.w600, // 标题字体粗细
          color: Colors.black, // 标题颜色

        ),
      ),
    );
  }

  Widget _buildAvatar(String avatarPath, int index) {
    return GestureDetector(
      onTap: () {
        if (index < onTapHandlers.length) {
          onTapHandlers[index](); // 根据索引执行对应的处理函数
        }
      },
      child: Container(
        width: section_height * 0.6,
        height: section_height * 0.6,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(avatarPath),
          ),
        ),
      ),
    );
  }

  Widget _buildMoreButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: 处理“更多”按钮的点击事件
      },
      child: Container(
        width: section_height * 0.6,
        height: section_height * 0.6,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          shape: BoxShape.rectangle,
          color: Colors.grey, // 更多按钮的颜色
        ),
        child: const Center(
          child: Text(
            '更多',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}







