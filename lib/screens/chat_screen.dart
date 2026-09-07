import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:day11_lab/service/gemini_api.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatUser user1 = ChatUser(
    id: '1',
    firstName: 'me',
  );

  ChatUser user2 = ChatUser(
    id: '2',
    firstName: 'bot',
  );

  List<ChatMessage> messagesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        toolbarHeight: 40,
        centerTitle: true,
        title: Text('Hey, Salma'),
      ),
      body: DashChat(
        messageOptions: MessageOptions(
          avatarBuilder: (
            p0,
            onPressAvatar,
            onLongPressAvatar,
          ) {
            return Image.asset('assets/bot.jpg',
              height: 30,
              width: 30,
            );
          },
        ),
        currentUser: user1,
        onSend: (message) async {
          messagesList.insert(0, message);

          setState(() {});

          String botMessage =
              await GeminiApi().sendRequest(message.text);

          ChatMessage reply = ChatMessage(
            user: user2,
            createdAt: DateTime.now(),
            text: botMessage,
          );

          messagesList.insert(0, reply);

          setState(() {});
        },
        messages: messagesList,
      ),
    );
  }
}
