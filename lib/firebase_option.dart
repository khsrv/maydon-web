// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      // не поддерживаемые:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError('This platform is not supported.');
    }
  }

  // ANDROID
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKFiips_FZcS98q4CjYrwEwSdXQz1vUjE',
    appId:
        '1:300068510532:android:8e96ac48563c9bbcbd9511', // из google-services.json -> mobilesdk_app_id
    messagingSenderId: '300068510532', // project_number
    projectId: 'maydon-3b545', // project_id
    storageBucket: 'maydon-3b545.firebasestorage.app', // storage_bucket
  );

  // iOS (iPhone/iPad)
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvDGDlSV_HLkB-h4g_Bpb8x7ohH69Sv0k', // API_KEY
    appId: '1:300068510532:ios:4c52e26b99579b24bd9511', // GOOGLE_APP_ID
    messagingSenderId: '300068510532', // GCM_SENDER_ID
    projectId: 'maydon-3b545', // PROJECT_ID
    storageBucket: 'maydon-3b545.firebasestorage.app', // STORAGE_BUCKET
    iosBundleId: 'com.maydon', // BUNDLE_ID
  );

  // macOS (можно использовать отдельное приложение в Firebase Console)
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'TODO_MAC_API_KEY',
    appId: 'TODO_MAC_APP_ID',
    messagingSenderId: 'TODO_SENDER_ID',
    projectId: 'TODO_PROJECT_ID',
    storageBucket: 'TODO.appspot.com',
    iosBundleId: 'com.your.macos.bundle',
  );

  // WEB
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'TODO_WEB_API_KEY',
    appId: 'TODO_WEB_APP_ID',
    messagingSenderId: 'TODO_SENDER_ID',
    projectId: 'TODO_PROJECT_ID',
    authDomain: 'TODO.firebaseapp.com',
    storageBucket: 'TODO.appspot.com',
    measurementId: 'G-XXXXXXX', // опционально, если есть
  );
}
