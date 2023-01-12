import 'dart:async';

import 'package:chat_gpt_app/chat_message.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreenUI extends StatefulWidget {
  const ChatScreenUI({super.key});

  @override
  State<ChatScreenUI> createState() => ChatScreenUIState();
}

class ChatScreenUIState extends State<ChatScreenUI> {
  TextEditingController _chatController = TextEditingController();
  List<ChatMessage> messageList = [];
  ChatGPT? chatGPT;
  StreamSubscription? _streamSubscription;
  bool isTyping = false;

  @override
  void initState() {
    chatGPT = ChatGPT.instance;
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void _sendMessage() {
    ChatMessage chatMessage =
        ChatMessage(text: _chatController.text.toString(), sender: "user");

    setState(() {
      isTyping = true;
      messageList.insert(0, chatMessage);
    });

    _chatController.clear();

    final request = CompleteReq(
        prompt: chatMessage.text, model: kTranslateModelV3, max_tokens: 200);
    _streamSubscription = chatGPT!
        .builder("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")
        .onCompleteStream(request: request)
        .listen((event) {
      print(event!.choices);
      ChatMessage botMessage = ChatMessage(
        text: event.choices[0].text,
        sender: "bot",
      );

      setState(() {
        isTyping = false;
        messageList.insert(0, botMessage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat GPT"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    padding: Vx.m8,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index];
                    })),
            if (isTyping) Text("bot typing........"),
            Container(
              decoration: BoxDecoration(color: context.cardColor),
              child: customTextfield(),
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextfield() {
    return Row(
      children: [
        Expanded(
            child: TextField(
          onSubmitted: (value) => _sendMessage(),
          controller: _chatController,
          decoration: const InputDecoration(
              hintText: "Send the message",
              hintStyle: TextStyle(color: Colors.black),
              border: InputBorder.none),
        )),
        IconButton(
            onPressed: () {
              _sendMessage();
            },
            icon: Icon(Icons.send))
      ],
    );
  }
}
