import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../firebase_options.dart';

class MainMethods {
  static Future<void> init() async {

    // init binding
    WidgetsFlutterBinding.ensureInitialized();

     // Load dotenv variables
    await dotenv.load();

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
