import 'package:flutter/material.dart';
import 'doctor.dart'; // 引入 Doctor 类
import 'process_indicator.dart'; // 引入 ProcessIndicator
import 'chat_message.dart'; // 聊天消息类

class StartConsultationPage extends StatefulWidget {
  final Doctor selectedDoctor;

  StartConsultationPage({Key? key, required this.selectedDoctor}) : super(key: key);

  @override
  _StartConsultationPageState createState() => _StartConsultationPageState();
}

class _StartConsultationPageState extends State<StartConsultationPage> {
  List<ChatMessage> messages = [];
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 初始化聊天消息
    messages.add(ChatMessage(message: "您好，我是${widget.selectedDoctor.name}。", isUserMessage: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('开始查询'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          ProcessIndicator(currentStep: 3), // 当前步骤为 3
          _buildDoctorInfo(),
          Expanded(
            child: _buildChatArea(),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.selectedDoctor.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ), // 医生姓名
          SizedBox(height: 8),
          Text(
            '诊金: ¥${widget.selectedDoctor.consultationFee.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ), // 诊金信息
          SizedBox(height: 10),
          Divider(
            thickness: 1, // 分隔线厚度
            color: Colors.grey[300], // 分隔线颜色
          ),
        ],
      ),
    );
  }


  Widget _buildChatArea() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return _buildChatMessage(messages[index]);
      },
    );
  }

  Widget _buildChatMessage(ChatMessage message) {
    return Row(
      mainAxisAlignment: message.isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!message.isUserMessage)
          Image.asset(widget.selectedDoctor.avatarUrl, width: 30), // 医生头像
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: message.isUserMessage ? Colors.blue[100] : Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message.message,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        if (message.isUserMessage)
          Icon(Icons.person, size: 30), // 代表用户的图标，可替换为用户头像
      ],
    );
  }

  Widget _buildInputArea() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: "请输入您的问题"),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: _handleSubmit,
        ),
      ],
    );
  }

  void _handleSubmit() {
    final String messageText = _textEditingController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(message: messageText, isUserMessage: true));
        _textEditingController.clear();
        _scrollToBottom();
      });
      // 此处可以添加将消息发送给医生的逻辑
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
