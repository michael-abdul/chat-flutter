import 'package:chat_flutter/chat_view/chat_view.dart';
import 'package:flutter/cupertino.dart';


mixin class FirstViewManager {
  final TextEditingController nameController = TextEditingController();

  navigateToChatView(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ChatView(name: nameController.text),
      ),
    );
  }
}