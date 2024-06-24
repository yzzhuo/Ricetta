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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBrhO8ZkaK8mqYj6JtKugdXD4Pg9I0gdqc',
    appId: '1:698670915631:web:0b299c451bcf07ee6166da',
    messagingSenderId: '698670915631',
    projectId: 'flutter-recipe-app-fa71f',
    authDomain: 'flutter-recipe-app-fa71f.firebaseapp.com',
    storageBucket: 'flutter-recipe-app-fa71f.appspot.com',
    measurementId: 'G-LRJ9HELELQ',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzh7xnfhl_mWq8TG3WcBF1MIBxLRwAU9g',
    appId: '1:698670915631:ios:23682f66dc5217d56166da',
    messagingSenderId: '698670915631',
    projectId: 'flutter-recipe-app-fa71f',
    storageBucket: 'flutter-recipe-app-fa71f.appspot.com',
    iosBundleId: 'com.example.flutterRecipeApp',
  );

}