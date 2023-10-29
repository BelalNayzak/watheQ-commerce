// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyAYdQyeqmtibJhFD4ZtezEbZa8V3qUqEog',
    appId: '1:260791201550:web:391922331509a3cc85b15f',
    messagingSenderId: '260791201550',
    projectId: 'watheq-commerce',
    authDomain: 'watheq-commerce.firebaseapp.com',
    storageBucket: 'watheq-commerce.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNmpmQ3kpwFCGpcTSEjgOJH37KMx2pxLU',
    appId: '1:260791201550:android:7a71d15bf96af67f85b15f',
    messagingSenderId: '260791201550',
    projectId: 'watheq-commerce',
    storageBucket: 'watheq-commerce.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2Thxu5uwjO2T8jrXBRLZLQ6CEwnLo4Mo',
    appId: '1:260791201550:ios:5635b6dcf0e724b785b15f',
    messagingSenderId: '260791201550',
    projectId: 'watheq-commerce',
    storageBucket: 'watheq-commerce.appspot.com',
    iosBundleId: 'com.watheq.ecommerce.app.watheq',
  );
}
