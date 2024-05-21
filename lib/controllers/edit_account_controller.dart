import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/user_controller.dart';
import 'package:waste_not/controllers/user_firebase_controller.dart';

import '../models/user.dart';

class EditAccountController extends GetxController {
  static EditAccountController get instance => Get.find();
  final UserFirebaseController userFirebaseController = Get.find();
  final UserController userController = Get.find();
  final TextEditingController usernameTextController = TextEditingController();

  editUsername() async {
    try {
      Map<String, dynamic> usernameJson = {
        'username': usernameTextController.text.trim()
      };
      await userFirebaseController.updateSingleField(usernameJson);

      UserModel updatedUser = userController.user.value
          .copyWith(username: usernameTextController.text.trim());
      userController.user.value = updatedUser;
    } catch (e) {
      throw "Something went wrong.";
    }
  }
}
