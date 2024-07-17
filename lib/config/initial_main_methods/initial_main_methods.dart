import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../firebase_options.dart';

class MainMethods {
  static Future<void> init() async {

    // init binding
    WidgetsFlutterBinding.ensureInitialized();

     // Load dotenv variables
    await dotenv.load();

    Stripe.publishableKey = 
      'pk_test_51PWJwnKYy5O2QMv5jSWIYL6OAoxdAsg6AmE96rPHJ9HAdRVviSVEQrTYKYgA5tiQPmp5AtkWFWeyNih2mk8GD5VN0015sWoAIz'; 
    // init firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // set the orientation to portrait only (there is no need for landscape)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
