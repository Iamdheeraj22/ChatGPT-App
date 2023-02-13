import 'package:chat_gpt_app/SuggestionList.dart';
import 'package:chat_gpt_app/model/ChatModel.dart';
import 'package:chat_gpt_app/model/chatGPT_response_model.dart';
import 'package:chat_gpt_app/size_config.dart';
import 'package:chat_gpt_app/widgets/message_ui.dart';
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
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: _chatList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return MessageUI(
                      type: _chatList[index].type,
                      text: _chatList[index].text,
                    );
                  }),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 30.h,
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: ListView.builder(
                        itemCount: GetSuggestionList().length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (sContext, sIndex) {
                          return Container(
                            margin: EdgeInsets.only(right: 10.w),
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                border: Border.all(color: Colors.grey)),
                            child: Center(
                                child: Text(GetSuggestionList()[sIndex].title)),
                          );
                        }),
                  ),
                  Container(
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
                                _chatList.add(
                                    ChatModel(type: 1, text: controller.text));
                                controller.text = '';
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
