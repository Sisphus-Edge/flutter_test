import 'package:flutter/material.dart';
import 'package:untitled/widges/home/quick_consultation/chat_message.dart';
import 'package:untitled/widges/home/quick_consultation/process_indicator.dart';
import 'package:untitled/widges/home/quick_consultation/scroll_controller.dart';
class QuickConsultationScreen extends StatefulWidget {
  @override
  _QuickConsultationScreenState createState() => _QuickConsultationScreenState();
}

class _QuickConsultationScreenState extends State<QuickConsultationScreen> {
  TextEditingController _textEditingController = TextEditingController();
  List<ChatMessage> messages = [];
  // 定义当前的流程步骤
  int currentStep = 1; // 1: 描述病情, 2: 匹配医生, 3: 开始查询

  void _handleUploadComplete() {
    setState(() {
      currentStep = 2; // 更新到下一个步骤，例如 "匹配医生"
      // 这里可以添加跳转到下一个页面的逻辑
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(),
          style: TextStyle(
            fontFamily: "ZHUOKAI",
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  String _getAppBarTitle() {
    switch (currentStep) {
      case 1:
        return "描述病情";
      case 2:
        return "匹配医生";
      case 3:
        return "开始查询";
      default:
        return "快速问诊";
    }
  }

  Widget _buildBody() {
    return Column(
      children: [
        ProcessIndicator(currentStep: currentStep),
        _buildServiceGuaranteeSection(),
        Expanded(
          child: ChatPage(messages: messages, textEditingController: _textEditingController,onUploadComplete: _handleUploadComplete,),
        )
      ],
    );
  }

  // 服务保障部分
  Widget _buildServiceGuaranteeSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.error_outline, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  "服务保障",
                  style: TextStyle(
                    fontFamily: "ZHUOKAI",
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Text(
              "职业医生 实名认证 多轮沟通 快捷高效",
              style: TextStyle(
                fontFamily: "ZHUOKAI",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: 2.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

