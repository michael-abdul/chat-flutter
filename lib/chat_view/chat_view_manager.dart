import 'package:chat_flutter/core/message.model.dart';
import 'package:chat_flutter/core/websocket_manager.dart';
import 'package:flutter/material.dart';

mixin class ChatViewManager {
  List<MessageModel> messages = [];
  final TextEditingController msgController = TextEditingController();

  void listenMessageEvent(VoidCallback setState) {
    WebSocketManager.instance.webSocketReceiver("chat_update", (data) {
      if (data is List) {
        // Agar massiv bo'lsa, har bir elementni MessageModel ga aylantiramiz
        for (var item in data) {
          messages.add(MessageModel.fromJson(item as Map<String, dynamic>));
        }
      } else if (data is Map) {
        // Agar obyekt bo'lsa, to'g'ridan-to'g'ri qo'shamiz
        messages.add(MessageModel.fromJson(data as Map<String, dynamic>));
      }
      setState();

    });
  }

  // listenMessageEvent(VoidCallback setState) {
  //   WebSocketManager.instance.webSocketReceiver("chat_update", (data) {
  //     messages.add(MessageModel.fromJson(data));
  //     setState();
  //   });
  // }

  // sendMessage(String sender, VoidCallback setState) {
  //   final MessageModel data =
  //       MessageModel(sender: sender, msg: msgController.text);
  //   WebSocketManager.instance.webSocketSender("chat_update", data.toJson());
  //   //Reset input
  //   msgController.text = "";
  //   setState();
  // }
  void sendMessage(String sender, String receiver, VoidCallback setState) {
 final MessageModel data = MessageModel(sender: sender, msg: msgController.text);
    WebSocketManager.instance.webSocketSender("private_message", {
      "senderId": sender,
      "receiverId": receiver,
      "message": msgController.text,

    });
    msgController.text = ""; // Reset input
    setState();
  }

  Alignment setMessageAlignment(String senderName, String userName) {
    switch (senderName == userName) {
      case true:
        return Alignment.topRight;
      case false:
        return Alignment.topLeft;
    }
  }
}
