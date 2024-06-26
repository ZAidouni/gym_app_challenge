// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBNy9Vp_03NihD8Ch4IeELnMeZnIjzCxmE',
    appId: '1:316878628891:web:61553c3e54b10bfd5530be',
    messagingSenderId: '316878628891',
    projectId: 'gym-app-challenge',
    authDomain: 'gym-app-challenge.firebaseapp.com',
    storageBucket: 'gym-app-challenge.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9Ed9kD4YBl58HKyP9t2NRuEqwdVLso8Y',
    appId: '1:316878628891:android:180a20071b7965be5530be',
    messagingSenderId: '316878628891',
    projectId: 'gym-app-challenge',
    storageBucket: 'gym-app-challenge.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2jY5Dh5jfkemrHxTwKwHtGZVDTBHEsg0',
    appId: '1:316878628891:ios:660d5a21eb8718dc5530be',
    messagingSenderId: '316878628891',
    projectId: 'gym-app-challenge',
    storageBucket: 'gym-app-challenge.appspot.com',
    iosBundleId: 'com.workout.workOutApp',
  );
}
