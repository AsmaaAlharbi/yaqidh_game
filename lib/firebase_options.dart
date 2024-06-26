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
        return macos;
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
    apiKey: 'AIzaSyBl9QzF0InfmRWGzKvs6OJn9xMpuUxgMIQ',
    appId: '1:80276160707:web:ca4baefdb154d8922da276',
    messagingSenderId: '80276160707',
    projectId: 'seniorproject-b001e',
    authDomain: 'seniorproject-b001e.firebaseapp.com',
    databaseURL: 'https://seniorproject-b001e-default-rtdb.firebaseio.com',
    storageBucket: 'seniorproject-b001e.appspot.com',
    measurementId: 'G-4WVTCM8EFG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfCWoiVb7RHtrRelHaST-kkDxZfy5g35w',
    appId: '1:80276160707:android:939123e30bde4a6e2da276',
    messagingSenderId: '80276160707',
    projectId: 'seniorproject-b001e',
    databaseURL: 'https://seniorproject-b001e-default-rtdb.firebaseio.com',
    storageBucket: 'seniorproject-b001e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOBrl7nXDyBwwuyLhWP2gNfIIdwR0Sc_g',
    appId: '1:80276160707:ios:557102fb08c927fc2da276',
    messagingSenderId: '80276160707',
    projectId: 'seniorproject-b001e',
    databaseURL: 'https://seniorproject-b001e-default-rtdb.firebaseio.com',
    storageBucket: 'seniorproject-b001e.appspot.com',
    iosBundleId: 'com.example.yaqidhGame',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAOBrl7nXDyBwwuyLhWP2gNfIIdwR0Sc_g',
    appId: '1:80276160707:ios:e5ee4c44df5af4a62da276',
    messagingSenderId: '80276160707',
    projectId: 'seniorproject-b001e',
    databaseURL: 'https://seniorproject-b001e-default-rtdb.firebaseio.com',
    storageBucket: 'seniorproject-b001e.appspot.com',
    iosBundleId: 'com.example.yaqidhGame.RunnerTests',
  );
}
