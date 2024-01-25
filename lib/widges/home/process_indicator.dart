import 'package:flutter/material.dart';

/**
 * 组件功能为显示“快速问诊所在流程而搭建的框架
 */
class ProcessIndicator extends StatelessWidget {
  final int currentStep;

  ProcessIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProcessStep("描述病情", 1),
        Icon(Icons.arrow_forward, color: Colors.black),
        _buildProcessStep("匹配医生", 2),
        Icon(Icons.arrow_forward, color: Colors.black),
        _buildProcessStep("开始查询", 3),
      ],
    );
  }

  Widget _buildProcessStep(String title, int step) {
    return Text(
      title,
      style: TextStyle(
        color: currentStep == step ? Colors.blue : Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
