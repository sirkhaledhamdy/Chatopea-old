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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5v_QtmfGBWJdRixiDlyHuOBKachA3lqY',
    appId: '1:869123553906:android:9104e2de7579d5de1a20eb',
    messagingSenderId: '869123553906',
    projectId: 'chatopea-91d74',
    databaseURL: 'https://chatopea-91d74-default-rtdb.firebaseio.com',
    storageBucket: 'chatopea-91d74.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZCTlTwcdL6O4aIMktsKsFBL1BuKnshqk',
    appId: '1:869123553906:ios:862c40edc924bb341a20eb',
    messagingSenderId: '869123553906',
    projectId: 'chatopea-91d74',
    databaseURL: 'https://chatopea-91d74-default-rtdb.firebaseio.com',
    storageBucket: 'chatopea-91d74.appspot.com',
    androidClientId: '869123553906-45mse7l31ajij13c8g3usjb4vpcpv15n.apps.googleusercontent.com',
    iosClientId: '869123553906-945p45kp2buaa11t2va5gbnclq9e8857.apps.googleusercontent.com',
    iosBundleId: 'com.blue.chatopea.chatopea',
  );
}
