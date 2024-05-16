// // import 'dart:async';
// //
// // import 'package:firebase_auth/firebase_auth.dart';
// // import '../controllers/user.dart';
// //
// // // class AuthenticationController extends GetxController {
// // //   static AuthController get instance => Get.find();
// // //
// // //   final deviceStorage = GetStorage();
// // //
// // //   @override
// // //   void onReady() {
// // //     FlutterNativeSplash.remove();
// // //     screenRedirect();
// // //   }
// // //
// // //   screenRedirect() async {
// // //     Get.offAll(const LoginView());
// // //     // Navigator.of(context).pushNamed("/auth"))
// // //   }
// // // }
// //
// // class AuthController {
// //   const AuthController(this._auth);
// //
// //   final FirebaseAuth _auth;
// //
// //   Stream<User?> get authStateChange => _auth.idTokenChanges();
// //
// //   Future<User?> signIn(String email, String password) async {
// //     try {
// //       UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
// //       return userCredential.user;
// //     } on FirebaseAuthException catch (e) {
// //       if (e.code == 'user-not-found'){
// //         throw AuthException("User not found");
// //       } else if (e.code == 'wrong-password'){
// //         throw AuthException("Wrong password");
// //       } else {
// //         throw AuthException("An error occurred. Please try again later.");
// //       }
// //     }
// //   }
// //
// //   Future<void> signOut() async{
// //     await _auth.signOut();
// //   }
// //
// //   static Future<bool> register(
// //       String email, String password, String name) async {
// //     try {
// //       UserCredential userCredential = await FirebaseAuth.instance
// //           .createUserWithEmailAndPassword(email: email, password: password);
// //       String uid = userCredential.user!.uid;
// //       UserController.createUser(email: email, name: name, uid: uid);
// //       return true;
// //     } on FirebaseAuthException catch (e) {
// //       if (e.code == 'weak-password') {
// //         print('The password provided is too weak.');
// //       } else if (e.code == 'email-already-in-use') {
// //         print('The account already exists for that email.');
// //       }
// //       return false;
// //     } catch (e) {
// //       print(e.toString());
// //       return false;
// //     }
// //   }
// // }
// //
// // class AuthException implements Exception{
// //   final String message;
// //   AuthException(this.message);
// //
// //   @override
// //   String toString(){
// //     return message;
// //   }
// // }
//
//
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:waste_not/providers/auth_provider.dart';
// import 'package:waste_not/state/auth.dart';
//
// class LoginController extends StateNotifier<LoginState>{
//   LoginController(this.ref) : super(const LoginStateInitial());
//
//   final Ref ref;
//
//   void login(String email, String password) async {
//     state = const LoginStateLoading();
//     try {
//       await ref.read(authRepositoryProvider).signIn(email, password);
//       state = const LoginStateSuccess();
//     } catch (e) {
//       state = LoginStateError(e.toString());
//     }
//   }
//
//   void signOut() async {
//     await ref.read(authRepositoryProvider).signOut();
//   }
// }
//
// final loginControllerProvider = StateNotifierProvider<LoginController, LoginState>((ref) {
//   return LoginController(ref);
// });