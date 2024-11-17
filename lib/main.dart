import 'package:e_commerce/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';
import 'utils/utils.dart';

class PlatformFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return FirebaseOptions(
          apiKey: dotenv.env['FIREBASE_API_KEY_ANDROID'] ?? 'FIREBASE_API_KEY Not found',
          appId: '1:189847202772:android:5d6353d45e488bd3980441',
          messagingSenderId: '189847202772',
          projectId: 'bmw-ecom',
          storageBucket: 'bmw-ecom.firebasestorage.app',
        );
      case TargetPlatform.iOS:
        return FirebaseOptions(
          apiKey: dotenv.env['FIREBASE_API_KEY_IOS'] ?? 'FIREBASE_API_KEY Not found',
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

void main() async {
  await dotenv.load(fileName: 'dotenv/.env.dev');
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  await Firebase.initializeApp(options: PlatformFirebaseOptions.currentPlatform, name: 'bmw-ecom');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignUpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LauncherProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdminProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: listenable,
        builder: (context, snapshot) {
          return MaterialApp(
            builder: (context, child) => Stack(
              fit: StackFit.expand,
              children: [
                if (child != null) child,

                /// Overlay elements
                if (locate<ProgressIndicatorController>().value) const ProgressIndicatorPopup(),
                ConnectivityIndicator(),
                Align(
                  alignment: Alignment.topLeft,
                  child: PopupContainer(
                    children: locate<PopupController>().value,
                  ),
                )
              ],
            ),
            title: 'BMW',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            home: const SplashScreen(),
          );
        });
  }

  Listenable get listenable => Listenable.merge([
        locate<PopupController>(),
        locate<ProgressIndicatorController>(),
      ]);
}
