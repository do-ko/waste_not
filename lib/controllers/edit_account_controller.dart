import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/user_controller.dart';
import 'package:waste_not/controllers/user_firebase_controller.dart';

import '../models/user.dart';

class EditAccountController extends GetxController {
  static EditAccountController get instance => Get.find();
  final UserFirebaseController userFirebaseController = Get.find();
  final UserController userController = Get.find();
  final TextEditingController usernameTextController = TextEditingController();
  GlobalKey<FormState> editUsernameFormKey = GlobalKey<FormState>();

  editUsername() async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false, // User cannot dismiss the dialog by tapping outside
      );

      if (!editUsernameFormKey.currentState!.validate()) {
        Get.back();
        return;
      }

      Map<String, dynamic> usernameJson = {
        'username': usernameTextController.text.trim()
      };
      await userFirebaseController.updateSingleField(usernameJson);

      UserModel updatedUser = userController.user.value
          .copyWith(username: usernameTextController.text.trim());
      userController.user.value = updatedUser;

      usernameTextController.text = '';
      Get.back();
      Get.snackbar("Success", "Username was changed", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.back();
      Get.snackbar("Error", "Something went wrong: $e", snackPosition: SnackPosition.BOTTOM);
    }
  }
}
