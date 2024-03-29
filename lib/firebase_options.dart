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
    apiKey: 'AIzaSyA4uI6d1ardNoKjpeZwmNalXeTjcPOBM6E',
    appId: '1:192050550184:web:5f252061ac92a51d38799d',
    messagingSenderId: '192050550184',
    projectId: 'classbuddy-4785b',
    authDomain: 'classbuddy-4785b.firebaseapp.com',
    databaseURL: 'https://classbuddy-4785b-default-rtdb.firebaseio.com',
    storageBucket: 'classbuddy-4785b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUGBOe_IOuFwT7eyeFbFdBN2cY0t4beiE',
    appId: '1:192050550184:android:539e89b17b19312e38799d',
    messagingSenderId: '192050550184',
    projectId: 'classbuddy-4785b',
    databaseURL: 'https://classbuddy-4785b-default-rtdb.firebaseio.com',
    storageBucket: 'classbuddy-4785b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBS1bsTs5OEIfmUlpoYvA0Gwd36XlgINXA',
    appId: '1:192050550184:ios:54be2834fcf63efa38799d',
    messagingSenderId: '192050550184',
    projectId: 'classbuddy-4785b',
    databaseURL: 'https://classbuddy-4785b-default-rtdb.firebaseio.com',
    storageBucket: 'classbuddy-4785b.appspot.com',
    androidClientId: '192050550184-5deiosts09osahjacfoo8j6agveu7u7o.apps.googleusercontent.com',
    iosClientId: '192050550184-uqe56oditoqml00v6a9dm884ulqi5fl2.apps.googleusercontent.com',
    iosBundleId: 'com.magicians.classbuddy',
  );
}
