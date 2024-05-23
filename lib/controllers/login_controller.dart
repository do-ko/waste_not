import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/views/home.dart';
import '../repositories/user.dart';
import '../models/user.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final deviceStorage = GetStorage();

  Future<void> login() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim());

      final userId = userCredential.user!.uid;
      final userRepository = Get.put(UserRepository());
      final userModel = await userRepository.getUser(userId);

      deviceStorage.write("userId", userModel.id);
      deviceStorage.write("username", userModel.username);
      deviceStorage.write("email", userModel.email);

      Get.offAll(() => const HomeView());
    } catch (e) {
      Get.snackbar("Error", "Login failed. Please try again.");
    }
  }
}