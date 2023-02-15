import 'dart:convert';
import 'dart:developer';
import 'package:chat_gpt_app/model/chatGPT_response_model.dart';
import 'package:chat_gpt_app/model/images_generation_model/image_generation_model.dart';
import 'package:chat_gpt_app/provider/provider.dart';
import 'package:chat_gpt_app/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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

//['256x256', '512x512', '1024x1024']
Future<ImagesGenerationsModel> imageGeneration(
    String prompt, BuildContext context) async {
  ProviderViewModel providerViewModel =
      Provider.of<ProviderViewModel>(context, listen: false);
  final response = await http.post(
    Uri.parse(Strings.imageGenerationEndPoint),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${Strings.apiKey}",
    },
    body: jsonEncode({"prompt": prompt, "n": 2, "size": "512x512"}),
  );

  if (response.statusCode == 200) {
    log('response :-${response.body}');
    return ImagesGenerationsModel.fromJson(jsonDecode(response.body));
  } else {
    log('response :-${response.body}');
    providerViewModel.setIsShow();
    throw Exception("Failed to generate text");
  }
}
