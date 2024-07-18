import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendMailjetEmail(String myEmail,String body) async {
  String apiKey = "34c0e4be87b475c66927bb120498351e";
  String secretKey = "5762b54a387e9d3b362b63e0e6b4b7e1";

  final url = Uri.parse('https://api.mailjet.com/v3.1/send');
  final credentials = base64Encode(utf8.encode('$apiKey:$secretKey'));

  final emailData = {
    'Messages': [
      {
        'From': {
          'Email': 'zakariaaidouni@gmail.com',
          'Name': 'My name'
        },
        'To': [
          {
            'Email': myEmail,
            'Name': 'My other name'
          }
        ],
        'Subject': 'My first Mailjet email',
        'TextPart': 'Dear passenger 1, welcome to Mailjet!',
        'HTMLPart': body
      }
    ]
  };

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Basic $credentials',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(emailData),
    );

    if (response.statusCode == 200) {
      print('Email sent successfully!');
    } else {
      print('Failed to send email: ${response.body}');
    }
  } catch (e) {
    print('Error sending email: $e');
  }
}
