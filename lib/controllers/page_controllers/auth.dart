import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'settings.dart';

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  DarkModeController darkModeController = Get.find();
  NotificationsController notificationsController = Get.find();
  LanguageController languageController = Get.find();
  NotificationsIntervalController notificationsIntervalController = Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() async {
    if (_auth.currentUser != null) {
      deviceStorage.writeIfNull('darkMode', false);
      deviceStorage.writeIfNull('notifications', true);
      deviceStorage.writeIfNull('language', 'English');
      deviceStorage.writeIfNull('notificationsInterval', 3);

      Get.toNamed("/home");
    } else {
      Get.toNamed("/login");
    }
  }

// login
  Future<UserCredential> login(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      } else {
        if (kDebugMode) {
          print('Error: ${e.code}');
        }
      }
      throw AuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw AuthException(e.code).message;
    }
  }

// register
  Future<UserCredential> register(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      } else {
        if (kDebugMode) {
          print('Error: ${e.code}');
        }
      }
      throw AuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw AuthException(e.code).message;
    }
  }

// logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
// deviceStorage.remove("username");
// deviceStorage.remove("email");
      deviceStorage.write('darkMode', darkModeController.darkMode.value);
      deviceStorage.write(
          'notifications', notificationsController.notifications.value);
      deviceStorage.write('language', languageController.language.value);
      deviceStorage.write('notificationsInterval',
          notificationsIntervalController.notificationInterval.value);
      Get.offAllNamed("/login");
    } catch (e) {
      throw "logout error";
    }
  }

  Future<void> changeEmail(String newEmail) async {
    try {
      await authUser!.verifyBeforeUpdateEmail(newEmail);
    } catch (e) {
      print(e.toString());
      throw "Email change failed.";
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      await authUser!.updatePassword(newPassword);
    } catch (e) {
      throw "Password change failed.";
    }
  }
}
