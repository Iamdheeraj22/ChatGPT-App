import 'package:chat_gpt_app/model/ChatModel.dart';
import 'package:chat_gpt_app/model/chatGPT_response_model.dart';
import 'package:chat_gpt_app/size_config.dart';
import 'package:chat_gpt_app/with_http/api_helper.dart';
import 'package:flutter/material.dart';

class ChatScreenUI extends StatefulWidget {
  const ChatScreenUI({Key? key}) : super(key: key);

  @override
  State<ChatScreenUI> createState() => _ChatScreenUIState();
}

class _ChatScreenUIState extends State<ChatScreenUI> {
  String _generatedText = "";
  TextEditingController controller = TextEditingController();
  String text = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Chat GPT',
            style: TextStyle(
                fontSize: 24,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w700),
          )),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(children: [
            Padding(
              padding: EdgeInsets.only(bottom: 100.h),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _chatList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Row(
                        children: [
                          Container(
                            height: 60.h,
                            width: 60.h,
                            decoration: BoxDecoration(
                                color: _chatList[index].type == 1
                                    ? Colors.redAccent
                                    : Colors.greenAccent,
                                borderRadius: BorderRadius.circular(200.h)),
                            child: Center(
                              child: Text(
                                _chatList[index].type == 1 ? 'U' : 'B',
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                    color: _chatList[index].type == 1
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Text(
                              _chatList[index]
                                  .text
                                  .trim()
                                  .replaceAll("\n", " "),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Card(
                        child: TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: 'Write a text'),
                    )),
                  ),
                  InkWell(
                    onTap: () async {
                      if (controller.text.isNotEmpty) {
                        setState(() {
                          _chatList
                              .add(ChatModel(type: 1, text: controller.text));
                        });
                        apiHit(controller.text);
                      } else {}
                    },
                    child: const Card(
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Icon(Icons.send)),
                    ),
                  )
                ],
              ),
            ),
          ])),
    );
  }

  void apiHit(text) async {
    final result = await generateText(text);
    setState(() {
      _chatList
          .add(ChatModel(type: 2, text: result.choices![0].text.toString()));
    });
  }
}

List<ChatModel> _chatList = [];
