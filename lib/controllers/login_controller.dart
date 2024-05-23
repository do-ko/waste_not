import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/views/home.dart';

class LoginController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final deviceStorage = GetStorage();

  login() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());

      deviceStorage.write("userId", userCredential.user!.uid); // Store user ID

      Get.offAll(() => const HomeView());
    } catch (e) {
      Get.snackbar("Error", "Login failed. Please try again.");
    }
  }
}