import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/functionsController.dart';
import 'package:work_out/checkout/stripe_checkout.dart';

class SubscriptionRedirectPage extends StatelessWidget {
  final FunctionsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Appelle redirectToCheckout après que la page a été construite
      try {
        redirectToCheckout(Get.context!);
      } catch (e, stacktrace) {
        print('Erreur: $e');
        print('Stacktrace: $stacktrace');
        // Gérer l'erreur selon vos besoins
      }
    });

   return Scaffold(
  backgroundColor: Colors.white, // Fond blanc du Scaffold
  body: Center(
  ),
);
  }
}
