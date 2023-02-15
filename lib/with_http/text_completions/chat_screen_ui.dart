import 'package:chat_gpt_app/with_http/text_completions/SuggestionList.dart';
import 'package:chat_gpt_app/model/ChatModel.dart';
import 'package:chat_gpt_app/model/chatGPT_response_model.dart';
import 'package:chat_gpt_app/provider/provider.dart';
import 'package:chat_gpt_app/util/size_config.dart';
import 'package:chat_gpt_app/widgets/message_ui.dart';
import 'package:chat_gpt_app/with_http/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreenUI extends StatefulWidget {
  const ChatScreenUI({Key? key}) : super(key: key);

  @override
  State<ChatScreenUI> createState() => _ChatScreenUIState();
}

class _ChatScreenUIState extends State<ChatScreenUI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderViewModel>(
      builder: (context, v, child) {
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
                      itemCount: v.chatList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return MessageUI(
                          type: v.chatList[index].type,
                          text: v.chatList[index].text,
                        );
                      }),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: v.getIsShow,
                        child: Container(
                          height: 30.h,
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          child: ListView.builder(
                              itemCount: GetSuggestionList().length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (sContext, sIndex) {
                                return InkWell(
                                  onTap: () {
                                    v.sendMessage(context,
                                        suggestion:
                                            GetSuggestionList()[sIndex].title);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10.w),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.w),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        border: Border.all(color: Colors.grey)),
                                    child: Center(
                                        child: Text(
                                            GetSuggestionList()[sIndex].title)),
                                  ),
                                );
                              }),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Card(
                                  child: TextFormField(
                                controller: v.msgTextController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 20),
                                    hintText: 'Write a text'),
                              )),
                            ),
                            InkWell(
                              onTap: () async {
                                //  v.sendMessage(context);
                                generateImages('');
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
      },
    );
  }
}
