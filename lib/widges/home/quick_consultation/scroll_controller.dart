import 'dart:convert';
import 'package:flutter/material.dart';
import 'chat_message.dart'; // 确保导入 ChatMessage 类
import 'match_doctor_page.dart';
import 'doctor.dart';
// 开始咨询的滑动聊天框
class ChatPage extends StatefulWidget {
  final List<ChatMessage> messages;
  final TextEditingController textEditingController;
  final Function onUploadComplete;

  ChatPage({Key? key, required this.messages, required this.textEditingController, required this.onUploadComplete}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addInitialMessages();
  }

  void _addInitialMessages() {
    widget.messages.addAll([
      ChatMessage(message: "您好，我是您的智能助手小瓜。", isUserMessage: false),
      ChatMessage(message: "请在下方输入框详细描述狗狗病情，以便更好的匹配医生并及时诊断。", isUserMessage: false),
      ChatMessage(message: "点击上传，即可进行匹配医生。", isUserMessage: false)
    ]);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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


  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                return _buildChatMessage(widget.messages[index]);
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.textEditingController,
                  decoration: InputDecoration(hintText: "请描述病情"),
                ),
              ),
              ElevatedButton(
                onPressed: _handleSubmit,
                child: Text("提交"),
              ),
              ElevatedButton(
                onPressed: _handleUpload,
                child: Text("上传"),
              ),
            ],
          ),
        ],
      );
  }

  void _handleSubmit() {
    final String messageText = widget.textEditingController.text;
    if (messageText.isNotEmpty) {
      setState(() {
        widget.messages.add(ChatMessage(message: messageText, isUserMessage: true));
        widget.textEditingController.clear();
      });
    }
  }

  void _handleUpload() async {
    // 模拟上传过程
    _sendMessageToServer(jsonEncode(widget.messages.map((m) => m.toJson()).toList()));
    widget.onUploadComplete(); // 通知外部上传完成
    // 假设上传成功后，会从服务器获取医生的列表
    //List<Doctor> doctors = await fetchDoctorsFromServer(); // 这是一个假设的函数
    List<Doctor> getFakeDoctors=[
        Doctor(
          name: "张医生",
          rating: 4.8,
          avatarUrl: "assets/logo/logo_pethome.png",
          specialty: "小动物内科",
          consultationFee: 150.0,
          consultationCount: 1200,
        ),
        Doctor(
          name: "李医生",
          rating: 4.5,
          avatarUrl: "assets/logo/logo_pethome.png",
          specialty: "外科",
          consultationFee: 180.0,
          consultationCount: 800,
        ),
        Doctor(
          name: "王医生",
          rating: 4.7,
          avatarUrl: "assets/logo/logo_pethome.png",
          specialty: "眼科",
          consultationFee: 200.0,
          consultationCount: 500,
        ),
      ];
    // 使用 Navigator 跳转到匹配医生页面
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MatchDoctorPage(doctors: getFakeDoctors)),
    );
  }
  void _sendMessageToServer(String data) {
    // 发送数据到服务器的实现
    print("Sending to server: $data");
    // 假设这里我们已经发送了数据到服务器...
    // 在这里实现发送消息到服务器的逻辑
    // 假设服务器返回的响应是一个 JSON 对象，包含字段 'response'
    // 示例代码：
    // final response = await http.post(Uri.parse('服务器URL'), body: {'message': message});
    // final responseData = json.decode(response.body);
    // setState(() {
    //   messages.add(ChatMessage(message: responseData['response'], isUserMessage: false));
    // });
  }

  Widget _buildChatMessage(ChatMessage message) {
    return Row(
      mainAxisAlignment: message.isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!message.isUserMessage)
          Image.asset('assets/logo/logo_pethome.png', width: 30), // AI 消息头像
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
          Image.asset('assets/logo/logo_pethome.png', width: 30), // 用户消息头像
      ],
    );
  }

}
