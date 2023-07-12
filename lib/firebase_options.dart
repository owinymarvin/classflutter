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
    apiKey: 'AIzaSyA2odZQ_xY4EkB5W_-zT2tkkj4GoiHddrQ',
    appId: '1:442573049846:web:31c9892cae852a82c2c1d7',
    messagingSenderId: '442573049846',
    projectId: 'equip-streams',
    authDomain: 'equip-streams.firebaseapp.com',
    storageBucket: 'equip-streams.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD29joDetMPxUu80lHARxdqKzVXMf92Rz4',
    appId: '1:442573049846:android:fb2f107dfea34065c2c1d7',
    messagingSenderId: '442573049846',
    projectId: 'equip-streams',
    storageBucket: 'equip-streams.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBPrEQebEvUcyvXGzWG_dFV0TiLNB6MMc8',
    appId: '1:442573049846:ios:8191b474b5bb056ec2c1d7',
    messagingSenderId: '442573049846',
    projectId: 'equip-streams',
    storageBucket: 'equip-streams.appspot.com',
    iosClientId: '442573049846-ktr70tll21iumlisu8la1vvt4samqtea.apps.googleusercontent.com',
    iosBundleId: 'com.example.firstpro',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBPrEQebEvUcyvXGzWG_dFV0TiLNB6MMc8',
    appId: '1:442573049846:ios:b35a7eb5506fb9b9c2c1d7',
    messagingSenderId: '442573049846',
    projectId: 'equip-streams',
    storageBucket: 'equip-streams.appspot.com',
    iosClientId: '442573049846-hj1f8dnj1665fbv8l1i01fkavmu67rrd.apps.googleusercontent.com',
    iosBundleId: 'com.example.firstpro.RunnerTests',
  );
}
