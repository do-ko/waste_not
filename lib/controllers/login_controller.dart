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

    Get.offAll(() => const HomeView());
  }
}

// class LoginController extends GetxController {
//   static LoginController get instance => Get.find();
//
//   final TextEditingController email = TextEditingController();
//   final TextEditingController password = TextEditingController();
//   final deviceStorage = GetStorage();
//
//   Future<void> login() async {
//     try {
//       final userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//               email: email.text.trim(), password: password.text.trim());
//
//       final userId = userCredential.user!.uid;
//       final userRepository = Get.put(UserRepository());
//       final userModel = await userRepository.getUser(userId);
//
//       deviceStorage.write("userId", userModel.id);
//       deviceStorage.write("username", userModel.username);
//       deviceStorage.write("email", userModel.email);
//
//       Get.offAll(() => const HomeView());
//     } catch (e) {
//       Get.snackbar("Error", "Login failed. Please try again.");
//     }
//   }
// }
