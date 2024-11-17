import 'package:e_commerce/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

import '../screens/screens.dart';
import '../utils/utils.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get userData => _user;

  // Check User State

  void checkAuthState(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (!context.mounted) return; // Ensures context is valid
        FirebaseAuth.instance.authStateChanges().listen(
          (User? user) {
            if (!context.mounted) return; // Double-checking context validity

            if (user == null) {
              CustomNavigator().goTo(context, const SignInScreen());
              Logger().e('User is currently Sign Out!');
            } else {
              _user = UserModel(
                  displayName: user.displayName ?? '',
                  userImage: user.photoURL ?? '',
                  email: user.email!,
                  uid: user.uid);
              CustomNavigator().goTo(context, const LauncherScreen());
              Logger().i('User is Sign In : ${user.email}');
            }
          },
        );
      },
    );
  }

  void updateUserModel(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user != null) {
          _user = UserModel(
              displayName: user.displayName ?? '', userImage: user.photoURL ?? '', email: user.email!, uid: user.uid);
        }
      },
    );
  }
}
