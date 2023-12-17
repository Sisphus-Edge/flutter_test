import 'package:flutter/material.dart';

class AppointmentsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Appointments',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          // 这里放置预约内容
          // 示例：ListView、Card 或其他预约组件
        ],
      ),
    );
  }
}
