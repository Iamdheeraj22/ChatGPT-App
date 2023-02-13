import 'dart:convert';
import 'dart:developer';
import 'package:chat_gpt_app/model/chatGPT_response_model.dart';
import 'package:http/http.dart' as http;

Future<ChatGPTModel> generateText(String prompt) async {
  const apiKey = "your apiKey";
  const endpoint = "https://api.openai.com/v1/completions";

  final response = await http.post(
    Uri.parse(endpoint),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $apiKey",
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
