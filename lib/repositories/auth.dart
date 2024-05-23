import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/views/login.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    Get.offAll(() => const LoginView());
  }

  // register
  Future<UserCredential> register(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Error: ${e.code}');
      }
      throw AuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw AuthException(e.code).message;
    }
  }
}


class AuthException implements Exception{
  final String message;
  AuthException(this.message);

  @override
  String toString(){
    return message;
  }
}