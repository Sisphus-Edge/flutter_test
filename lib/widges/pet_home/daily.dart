import 'dart:ffi';

import 'package:flutter/material.dart';
import 'numeric/numeric_container.dart';
import 'habit/habit.dart';


class DailyPage extends StatelessWidget {
  final DateTime date;

  DailyPage({required this.date});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Center(
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.contain, // 限制子部件的大小，确保其不会超出容器的边界
              child:_buildTopDateArea(date),
            ),
            SizedBox(height: 20),
            MultiRowBlock(quantity: 1, section_width: screenWidth,),
          ],
        ),
      ),
    );
  }

  /// 顶部时间
  Widget _buildTopDateArea(DateTime date) {
    return Container(
      color: Colors.orange,
      height: 50,
      width: 200,
      margin: EdgeInsets.only(right: 2),
      // 设置右边距离为2
      child: Text(
      'Date: ${date.year}-${date.month}-${date.day}',
      style: TextStyle(fontSize: 20,),
          textAlign: TextAlign.left,
    ),);
  }
}
