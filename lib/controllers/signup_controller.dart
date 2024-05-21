import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/controllers/user_firebase_controller.dart';
import 'package:waste_not/views/home.dart';

import '../models/user.dart';
import 'auth_controller.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final deviceStorage = GetStorage();

  signUp() async {
    try {
      if (!signupFormKey.currentState!.validate()) {
        return;
      }

      final userCredential = await AuthController.instance
          .register(email.text.trim(), password.text.trim());

      final userModel = UserModel(
          id: userCredential.user!.uid,
          email: email.text.trim(),
          username: username.text.trim());

      final userRepository = Get.put(UserFirebaseController());
      userRepository.saveUser(userModel);

      // deviceStorage.write("username", userModel.username);
      // deviceStorage.write("email", userModel.email);
      // deviceStorage.write("username", userModel.username);

      Get.offAll(() => const HomeView());
    } catch (e) {
      throw "Something went wrong.";
    } finally {}
  }
}
