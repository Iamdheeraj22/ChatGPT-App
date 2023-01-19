import 'dart:async';

import 'package:chat_gpt_app/SuggestionList.dart';
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
  final TextEditingController _chatController = TextEditingController();
  List<ChatMessage> messageList = [];
  List<Suggestion> _suggestionList = [];
  ChatGPT? chatGPT;
  StreamSubscription? _streamSubscription;
  bool isTyping = false;

  @override
  void initState() {
    _suggestionList = GetSuggestionList();
    chatGPT = ChatGPT.instance;
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void _sendMessage() {
    ChatMessage chatMessage = ChatMessage(
        text: _chatController.text.trim().toString(), sender: "user");

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
      if (event == null) {
        ChatMessage botMessage = const ChatMessage(
          text: "Something went wrongs",
          sender: "bot",
        );
        setState(() {
          isTyping = false;
          messageList.insert(0, botMessage);
        });
      } else {
        ChatMessage botMessage = ChatMessage(
          text: event!.choices[0].text,
          sender: "bot",
        );

        setState(() {
          isTyping = false;
          messageList.insert(0, botMessage);
        });
      }
    });
  }

  void _sendSuggestionMessage({String title = ""}) {
    ChatMessage chatMessage = ChatMessage(text: title, sender: "user");

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
      if (event == null) {
        ChatMessage botMessage = const ChatMessage(
          text: "Something went wrongs",
          sender: "bot",
        );
        setState(() {
          isTyping = false;
          messageList.insert(0, botMessage);
        });
      } else {
        ChatMessage botMessage = ChatMessage(
          text: event!.choices[0].text,
          sender: "bot",
        );

        setState(() {
          isTyping = false;
          messageList.insert(0, botMessage);
        });
      }
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
            if (isTyping == false)
              Container(
                height: 30,
                child: ListView.builder(
                  itemCount: _suggestionList.length,
                  shrinkWrap: true,
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        _sendSuggestionMessage(
                            title: _suggestionList[index].title.toString());
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            _suggestionList[index].title,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
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
              if (_chatController.text.isEmpty) {
                return;
              } else {
                _sendMessage();
              }
            },
            icon: Icon(Icons.send))
      ],
    );
  }
}
