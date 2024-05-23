import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/user_firebase_controller.dart';

import '../models/user.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final UserFirebaseController userFirebaseController = Get.find();
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
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Future createUser(
      {required String email,
      required String name,
      required String uid}) async {
    final docUser = FirebaseFirestore.instance.collection('Users').doc(uid);
    final user = UserModel(id: uid, email: email, username: name);
    final jsonUser = user.toJson();
    await docUser.set(jsonUser);
  }

  Future<void> updateUserRecord(json) async {
    try {
      userFirebaseController.updateSingleField(json);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance
      .collection('Users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList());
}
