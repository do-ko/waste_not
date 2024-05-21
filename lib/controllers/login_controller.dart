import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../views/home.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final deviceStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final hidePassword = true.obs;
  final rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print("==================================================");
      print(deviceStorage.read("REMEMBER_ME_EMAIL"));
      print(deviceStorage.read("REMEMBER_ME_PASSWORD"));
    }
    if (deviceStorage.read("REMEMBER_ME_EMAIL") != null) {
      email.text = deviceStorage.read("REMEMBER_ME_EMAIL");
    }
    if (deviceStorage.read("REMEMBER_ME_PASSWORD") != null) {
      password.text = deviceStorage.read("REMEMBER_ME_PASSWORD");
    }
  }

  Future<void> signIn() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    if (rememberMe.value) {
      deviceStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
      deviceStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
    } else {
      deviceStorage.remove("REMEMBER_ME_EMAIL");
      deviceStorage.remove("REMEMBER_ME_PASSWORD");
    }

    await AuthController.instance
        .login(email.text.trim(), password.text.trim());

    // final userRepository = Get.put(UserFirebaseController());
    // UserModel user = await userRepository.getUser(userCredentials.user!.uid);
    //
    // deviceStorage.write("username", user.username);
    // deviceStorage.write("email", user.email);

    Get.offAll(() => const HomeView());
  }
}
