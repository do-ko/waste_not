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
  final TextEditingController oldEmailTextController = TextEditingController();
  final TextEditingController newEmailTextController = TextEditingController();

  GlobalKey<FormState> editUsernameFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editEmailFormKey = GlobalKey<FormState>();

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

  editEmail () async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false, // User cannot dismiss the dialog by tapping outside
      );

      if (!editEmailFormKey.currentState!.validate()) {
        Get.back();
        return;
      }

      Map<String, dynamic> emailJson = {
        'email': newEmailTextController.text.trim()
      };
      await userFirebaseController.updateSingleField(emailJson);

      UserModel updatedUser = userController.user.value
          .copyWith(email: newEmailTextController.text.trim());
      userController.user.value = updatedUser;

      oldEmailTextController.text = '';
      newEmailTextController.text = '';
      Get.back();
      Get.snackbar("Success", "Email was changed", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.back();
      Get.snackbar("Error", "Something went wrong: $e", snackPosition: SnackPosition.BOTTOM);
    }
  }
}
