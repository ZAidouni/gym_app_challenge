import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {

  Future<String> generateDescription(String prompt) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final String apiKey = dotenv.env['OPENAI_API_KEY']!;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages': [
        {
          'role': 'user',
          'content': prompt,
        },
      ],
      'max_tokens': 100,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'].trim();
      } else {
        final errorData = jsonDecode(utf8.decode(response.bodyBytes));
        print('Erreur HTTP ${response.statusCode}: ${errorData['error']['message']}');
        return 'Erreur ${response.statusCode}: ${errorData['error']['message']}';
      }
    } catch (e) {
      print('Exception lors de la génération de la description: $e');
      return 'Erreur: $e';
    }
  }
}
