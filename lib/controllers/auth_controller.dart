import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

import '../screens/screens.dart';
import '../utils/utils.dart';

class AuthController {
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
              CustomNavigator().goTo(context, const Dashboard());
              Logger().i('User is Sign In : ${user.email}');
            }
          },
        );
      },
    );
  }

  // Create User Account with Email

  Future<void> createUserAccountWithEmail({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Logger().i('Account created with : ${credential.user!.email}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger().e('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Logger().e('The account already exists for that email.');
        throw UserAlreadyExistsException('The account already exists for this email.');
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  // SignIn with Email

  Future<void> signInWithEmail({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Logger().i(credential.user!.email);
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
      if (e.code == 'user-not-found') {
        Logger().e('No user found for that email.');
        throw UserNotFoundException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Logger().e('Wrong password provided for that user.');
        throw WrongPasswordException('Wrong password provided for that user.');
      } else if (e.code == 'invalid-credential') {
        Logger().e('Invalid credential');
        throw InvalidCredentialException('Invalid credential provided for that user.');
      }
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class UserNotFoundException implements Exception {
  final String message;

  UserNotFoundException(this.message);
}

class UserAlreadyExistsException implements Exception {
  final String message;
  UserAlreadyExistsException(this.message);
}

class WeakPasswordException implements Exception {
  final String message;
  WeakPasswordException(this.message);
}

class WrongPasswordException implements Exception {
  final String message;
  WrongPasswordException(this.message);
}

class InvalidCredentialException implements Exception {
  final String message;
  InvalidCredentialException(this.message);
}
