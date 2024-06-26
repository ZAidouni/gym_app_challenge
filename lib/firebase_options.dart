import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

final androidApiKey = dotenv.env['ANDROID_API_KEY'];
final iosApiKey = dotenv.env['IOS_API_KEY'];
final webApiKey = dotenv.env['WEB_API_KEY'];

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macOS - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static final FirebaseOptions web = FirebaseOptions(
    apiKey: webApiKey ?? '',
    appId: '1:316878628891:web:61553c3e54b10bfd5530be',
    messagingSenderId: '316878628891',
    projectId: 'gym-app-challenge',
    authDomain: 'gym-app-challenge.firebaseapp.com',
    storageBucket: 'gym-app-challenge.appspot.com',
  );

  static FirebaseOptions get android {
    return FirebaseOptions(
      apiKey: androidApiKey ?? '',
      appId: '1:316878628891:android:180a20071b7965be5530be',
      messagingSenderId: '316878628891',
      projectId: 'gym-app-challenge',
      storageBucket: 'gym-app-challenge.appspot.com',
    );
  }

  static FirebaseOptions get ios {
    return FirebaseOptions(
      apiKey: iosApiKey ?? '',
      appId: '1:316878628891:ios:660d5a21eb8718dc5530be',
      messagingSenderId: '316878628891',
      projectId: 'gym-app-challenge',
      storageBucket: 'gym-app-challenge.appspot.com',
      iosBundleId: 'com.workout.workOutApp',
    );
  }
}
