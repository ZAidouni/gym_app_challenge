import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:work_out/constants.dart';

class Server {
  Future<String> createCheckout() async {
    final auth = 'Basic ' + base64Encode(utf8.encode('$secretKey:'));
    final body = {
      'line_items': [
        {
          'price': nikesPriceId,
          'quantity': 1,
        }
      ],
      'mode': 'subscription', 
      'success_url': 'http://localhost:8080/#/redirect/success',
      'cancel_url': 'http://localhost:8080/#/redirect/cancel',
    };

    try {
      final result = await Dio().post(
        "https://api.stripe.com/v1/checkout/sessions",
        data: body,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: auth},
          contentType: "application/x-www-form-urlencoded",
        ),
      );
      return result.data['id'];
    } on DioError catch (e, s) {
      print(e.response);
      throw e;
    }
  }
}
