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
    // generateText(widget.prompt).then((text) {
    //   setState(() {
    //     _generatedText = text;
    //   });
    // });
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
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(_generatedText),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
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
                    onTap: () {
                      if (controller.text.isNotEmpty) {
                        generateText(controller.text.toString());
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
}
