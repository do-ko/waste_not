import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/auth_controller.dart';
import 'package:waste_not/models/user.dart';

class UserFirebaseController extends GetxController {
  static UserFirebaseController get instance => Get.find();
  final FirebaseFirestore db = FirebaseFirestore.instance;

// Repository methods to communicate with db
  Future<void> saveUser(UserModel user) async {
    try {
      await db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw CreateUserException(e.code).message;
    }
  }

  Future<UserModel> getUser() async {
    try {
      final user = await db
          .collection("Users")
          .doc(AuthController.instance.authUser?.uid)
          .get();
      return UserModel.fromMap(user.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      throw CreateUserException(e.code).message;
    }
  }

  Future<void> updateUserDetails(UserModel user) async {
    try {
      await db.collection("Users").doc(user.id).update(user.toJson());
    } on FirebaseException catch (e) {
      throw UpdateUserException(e.code).message;
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await db
          .collection("Users")
          .doc(AuthController.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw UpdateUserException(e.code).message;
    }
  }

  Future<void> removeUser(String userId) async {
    try {
      await db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw UpdateUserException(e.code).message;
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

class UpdateUserException implements Exception {
  final String message;

  UpdateUserException(this.message);

  @override
  String toString() {
    return message;
  }
}

class DeleteUserException implements Exception {
  final String message;

  DeleteUserException(this.message);

  @override
  String toString() {
    return message;
  }
}
