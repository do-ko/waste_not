import 'package:get/get.dart';
import 'package:waste_not/controllers/user_firebase_controller.dart';

import '../models/user.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final UserFirebaseController userFirebaseController =
      Get.put(UserFirebaseController());
  Rx<UserModel> user = UserModel(email: '', username: '').obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      final userFetched = await userFirebaseController.getUser();
      user.value = userFetched;
    } catch (e) {
      user(UserModel(email: '', username: 'failed'));
      print(e.toString());
    }
  }

  // Future<void> updateUserRecord(json) async {
  //   try {
  //     userFirebaseController.updateSingleField(json);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
