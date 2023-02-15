import 'package:chat_gpt_app/model/ChatModel.dart';
import 'package:chat_gpt_app/model/chatGPT_response_model.dart';
import 'package:chat_gpt_app/model/images_generation_model/ImageTextModel.dart';
import 'package:chat_gpt_app/util/size_config.dart';
import 'package:chat_gpt_app/with_http/api_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProviderViewModel extends ChangeNotifier {
  bool isShow = true;
  List<ChatModel> chatList = [];
  List<ImageTextModel> imageGenerationsList = [];
  setIsShow() {
    isShow = !isShow;
    notifyListeners();
  }

  void sendMessage(BuildContext context, {String suggestion = ''}) async {
    setIsShow();
    if (msgTextController.text.isNotEmpty) {
      chatList.add(ChatModel(type: 1, text: msgTextController.text));
      final result = await generateText(msgTextController.text);
      msgTextController.text = '';

      chatList
          .add(ChatModel(type: 2, text: result.choices![0].text.toString()));

      setIsShow();
      notifyListeners();
    } else if (msgTextController.text.isEmpty && suggestion.isNotEmpty) {
      chatList.add(ChatModel(type: 1, text: suggestion));
      final result = await generateText(msgTextController.text);
      chatList
          .add(ChatModel(type: 2, text: result.choices![0].text.toString()));
      setIsShow();
      notifyListeners();
    } else {
      showSnackBar('write the text', context);
      setIsShow();
    }
  }

  void generateImages(BuildContext context) async {
    setIsShow();
    if (imageTextController.text.isNotEmpty) {
      imageGenerationsList
          .add(ImageTextModel(type: 1, promptText: imageTextController.text));
      final result = await imageGeneration(imageTextController.text);
      imageGenerationsList.add(ImageTextModel(type: 2, imageData: result.data));
      setIsShow();
      notifyListeners();
    } else {
      showSnackBar('write the text', context);
      setIsShow();
    }
  }

  bool get getIsShow => isShow;

  //Text Completions TextEditingController
  final TextEditingController _msgTextController = TextEditingController();
  TextEditingController get msgTextController => _msgTextController;

  //Image Generation prompt TextEditingController
  final TextEditingController _imageTextController = TextEditingController();
  TextEditingController get imageTextController => _imageTextController;

  //Show error snack bar
  showSnackBar(String data, BuildContext context, {Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        // margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        elevation: 5,
        content: Text(data,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            )),
        duration: duration ?? const Duration(seconds: 2),
      ),
    );
  }
}
