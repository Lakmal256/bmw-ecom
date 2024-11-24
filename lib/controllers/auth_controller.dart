import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

import '../models/models.dart';

class AuthController {
  // Create User Account with Email

  Future<void> createUserAccountWithEmail({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        addUser(value.user!.uid, value.user?.displayName ?? '', email);
      });
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

  // Send Password Reset Mail

  Future<void> sendPasswordResetEmail({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  //SignIn With Google

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  CollectionReference users = FirebaseFirestore.instance.collection("Users");

  // Update User Name

  Future<void> updateUserName({required String userName}) async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.updateDisplayName(userName);
    users.doc(user!.uid).update({"name": userName});
  }

  // Save User Data

  Future<void> addUser(String uid, String name, String email) {
    return users.doc(uid).set({
      "name": name,
      "uid": uid,
      "email": email,
    }).then((value) {
      Logger().i("User Added");
    }).catchError((e) {
      Logger().e(e);
    });
  }

  //fetch user data
  Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot userData = await users.doc(uid).get();
      return UserModel.fromMap(userData.data() as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
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
