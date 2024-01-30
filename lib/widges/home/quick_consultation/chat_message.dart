import 'package:flutter/material.dart';
class ChatMessage {
  String message;
  bool isUserMessage; // true 表示用户消息, false 表示 AI 消息

  ChatMessage({required this.message, required this.isUserMessage});

  // 将 ChatMessage 对象转换为 map，方便后续转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'isUserMessage': isUserMessage,
    };
  }
}





