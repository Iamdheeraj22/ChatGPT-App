import 'dart:convert';
import 'dart:developer';
import 'package:chat_gpt_app/model/chatGPT_response_model.dart';
import 'package:chat_gpt_app/model/images_generation_model/image_generation_model.dart';
import 'package:chat_gpt_app/util/strings.dart';
import 'package:http/http.dart' as http;

Future<ChatGPTModel> generateText(String prompt) async {
  final response = await http.post(
    Uri.parse(Strings.textComplitionEndPoint),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${Strings.apiKey}",
    },
    body: jsonEncode({
      "prompt": prompt,
      "max_tokens": 100,
      "temperature": 0.5,
      "model": 'text-davinci-003'
    }),
  );

  if (response.statusCode == 200) {
    log('response :-${response.body}');
    return ChatGPTModel.fromJson(jsonDecode(response.body));
  } else {
    log('response :-${response.body}');
    throw Exception("Failed to generate text");
  }
}

Future<ImagesGenerationsModel> imageGeneration(String prompt) async {
  final response = await http.post(
    Uri.parse(Strings.imageGenerationEndPoint),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${Strings.apiKey}",
    },
    body: jsonEncode({"prompt": "cat", "n": 2, "size": "1024x1024"}),
  );

  if (response.statusCode == 200) {
    log('response :-${response.body}');
    return ImagesGenerationsModel.fromJson(jsonDecode(response.body));
  } else {
    log('response :-${response.body}');
    throw Exception("Failed to generate text");
  }
}
