import 'package:e_commerce/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform;

import 'utils/theme.dart';

class PlatformFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const FirebaseOptions(
          apiKey: 'AIzaSyA2QbICKpUmai0NepfHAr7QiwDtPC7zYwo',
          appId: '1:189847202772:android:5d6353d45e488bd3980441',
          messagingSenderId: '189847202772',
          projectId: 'bmw-ecom',
          storageBucket: 'bmw-ecom.firebasestorage.app',
        );
      case TargetPlatform.iOS:
        return const FirebaseOptions(
          apiKey: 'AIzaSyCeJTwXnJWXlSTHfgjO8WjnNxkJhkymEw4',
          appId: '1:189847202772:ios:d42f35a100ad9fb7980441',
          messagingSenderId: '189847202772',
          projectId: 'bmw-ecom',
          storageBucket: 'bmw-ecom.firebasestorage.app',
          iosBundleId: 'com.bmw.ecom',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: PlatformFirebaseOptions.currentPlatform, name: 'bmw-ecom');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMW',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const Dashboard(),
    );
  }
}
