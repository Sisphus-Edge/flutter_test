import 'package:flutter/material.dart';

class TweetsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // 这里放置您的推文内容
          // 示例：Card、Container 或其他推文组件
        ],
      ),
    );
  }
}
