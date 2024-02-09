import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZPwqh1owk8Bt7FU8M4EPJbYQFOxhrvTQ',
    appId: '1:994493490810:android:e0362b23c41efb3bf9bdc3',
    messagingSenderId: '994493490810',
    projectId: 'zen-fit-hub',
    storageBucket: 'zen-fit-hub.appspot.com',
  );
}
