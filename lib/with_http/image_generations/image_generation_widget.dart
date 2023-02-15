import 'package:chat_gpt_app/model/images_generation_model/ImageTextModel.dart';
import 'package:chat_gpt_app/model/images_generation_model/image_generation_model.dart';
import 'package:flutter/material.dart';

class ImageGenerationWidget extends StatelessWidget {
  ImageGenerationWidget({Key? key, required this.model}) : super(key: key);
  ImageTextModel model;
  @override
  Widget build(BuildContext context) {
    return model.type == 1
        ? TextItemWidget(promptText: model.promptText.toString())
        : ImageItemWidget(imageData: model.imageData!);
  }
}

class TextItemWidget extends StatelessWidget {
  TextItemWidget({Key? key, required this.promptText}) : super(key: key);
  String promptText;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Prompt Text'),
    );
  }
}

class ImageItemWidget extends StatelessWidget {
  ImageItemWidget({super.key, required this.imageData});
  List<ImageData> imageData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Image'),
    );
  }
}
