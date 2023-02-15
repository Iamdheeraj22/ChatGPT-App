import 'package:chat_gpt_app/model/images_generation_model/image_generation_model.dart';

class ImageTextModel {
  int type;
  String? promptText;
  List<ImageData>? imageData;
  ImageTextModel({
    required this.type,
    this.promptText,
    this.imageData,
  });
}
