import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/repositories/auth.dart';
import 'package:waste_not/repositories/user.dart';
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


  signUp() async {
    try {
      final userCredential = await AuthRepository.instance
          .register(email.text.trim(), password.text.trim());

      final userModel = UserModel(
          id: userCredential.user!.uid,
          email: email.text.trim(),
          username: username.text.trim());

      final userRepository = Get.put(UserRepository());
      userRepository.saveUser(userModel);

      deviceStorage.write("username", userModel.username);
      deviceStorage.write("email", userModel.email);
      deviceStorage.write("userId", userModel.id); // needed for later


      Get.offAll(() => const HomeView());
    } catch (e) {
      throw "Something went wrong.";
    } finally {}
  }
}

