import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:waste_not/models/user.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> saveUser(UserModel user) async {
    try {
      await db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw CreateUserException(e.code).message;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      final user = await db.collection("Users").doc(uid).get();
      return UserModel.fromMap(user.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      throw CreateUserException(e.code).message;
    }
  }
}

class CreateUserException implements Exception {
  final String message;

  CreateUserException(this.message);

  @override
  String toString() {
    return message;
  }
}