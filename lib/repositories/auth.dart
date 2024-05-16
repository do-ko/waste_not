import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/views/login.dart';

// class AuthRepository {
//   const AuthRepository(this._auth);
//
//   final FirebaseAuth _auth;
//
//   Stream<User?> get authStateChange => _auth.idTokenChanges();
//
//   // User get user => _auth.currentUser;
//
//   Future<User?> signIn(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found'){
//         throw AuthException("User not found");
//       } else if (e.code == 'wrong-password'){
//         throw AuthException("Wrong password");
//       } else {
//         throw AuthException("An error occurred. Please try again later.");
//       }
//     }
//   }
//
//   Future<void> signOut() async{
//     await _auth.signOut();
//   }

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
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
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

// static Future<bool> register(
//     String email, String password, String name) async {
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password);
//     String uid = userCredential.user!.uid;
//     UserController.createUser(email: email, name: name, uid: uid);
//     return true;
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('The password provided is too weak.');
//     } else if (e.code == 'email-already-in-use') {
//       print('The account already exists for that email.');
//     }
//     return false;
//   } catch (e) {
//     print(e.toString());
//     return false;
//   }
// }
// }

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}
