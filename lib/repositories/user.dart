import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUser(String userId) async {
    final doc = await _firestore.collection('Users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    } else {
      throw Exception('User not found');
    }
  }

  Future<void> saveUser(UserModel user) async {
    await _firestore.collection('Users').doc(user.id).set(user.toJson());
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:waste_not/models/user.dart';

// class UserRepository extends GetxController {
//   static UserRepository get instance => Get.find();
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   Future<void> saveUser(UserModel user) async {
//     try {
//       await db.collection("Users").doc(user.id).set(user.toJson());
//     } on FirebaseException catch (e) {
//       throw CreateUserException(e.code).message;
//     }
//   }
// }

// class CreateUserException implements Exception {
//   final String message;

//   CreateUserException(this.message);

//   @override
//   String toString() {
//     return message;
//   }
// }