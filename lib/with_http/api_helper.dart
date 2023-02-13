import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future<String> generateText(String prompt) async {
  const apiKey = "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";
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
    return response.body;
  } else {
    log('response :-${response.body}');
    throw Exception("Failed to generate text");
  }
}
