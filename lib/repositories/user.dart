import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:waste_not/models/user.dart';
import 'package:waste_not/repositories/auth.dart';

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
      final user = await db
          .collection("Users")
          .doc(AuthRepository.instance.authUser?.uid)
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
      await db.collection("Users").doc(AuthRepository.instance.authUser?.uid).update(json);
    } on FirebaseException catch (e) {
      throw UpdateUserException(e.code).message;
    }
  }

  Future<void> removeUser(String userId) async {
    try {
      await db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw DeleteUserException(e.code).message;
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
