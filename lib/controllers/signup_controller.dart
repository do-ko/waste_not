import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/controllers/auth_controller.dart';
import 'package:waste_not/controllers/user_firebase_controller.dart';
import 'package:waste_not/views/home.dart';

import '../models/user.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final deviceStorage = GetStorage();

  Future<void> signUp() async {
    try {
      final userCredential = await AuthController.instance
          .register(email.text.trim(), password.text.trim());

      final userModel = UserModel(
        id: userCredential.user!.uid,
        email: email.text.trim(),
        username: username.text.trim(),
      );

      final UserFirebaseController userFirebaseController =
          Get.put(UserFirebaseController());
      await userFirebaseController.saveUser(userModel);

      deviceStorage.write("username", userModel.username);
      deviceStorage.write("email", userModel.email);
      deviceStorage.write("userId", userModel.id); // Store user ID

      Get.offAll(() => const HomeView());
    } catch (e) {
      Get.snackbar("Error", "Sign up failed. Please try again.");
    }
  }
}
