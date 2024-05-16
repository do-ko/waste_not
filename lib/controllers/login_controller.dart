import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/repositories/auth.dart';

import '../models/user.dart';
import '../repositories/user.dart';
import '../views/home.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final deviceStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final hidePassword = true.obs;
  final rememberMe = false.obs;


  // @override
  // void onInit() {
  //   super.onInit();
  //   email.text = deviceStorage.read("REMEMBER_ME_EMAIL");
  //   password.text = deviceStorage.read("REMEMBER_ME_PASSWORD");
  // }

  Future<void> signIn() async {
    if (!loginFormKey.currentState!.validate()){
      return;
    }

    if (rememberMe.value) {
      deviceStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
      deviceStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
    }

    final userCredentials = await AuthRepository.instance
        .login(email.text.trim(), password.text.trim());

    final userRepository = Get.put(UserRepository());
    UserModel user = await userRepository.getUser(userCredentials.user!.uid);
    
    deviceStorage.write("username", user.username);
    deviceStorage.write("email", user.email);

    Get.offAll(() => const HomeView());
  }
}
