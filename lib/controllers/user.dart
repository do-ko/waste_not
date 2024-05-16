import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/user.dart';

class UserController extends GetxController {
  final String userId;
  Rx<User>? user;

  UserController({required this.userId}) {
    user = getUser(userId)?.obs;
  }

  User? getUser(String userId) {
    return null;
  }

  static Future createUser(
      {required String email,
      required String name,
      required String uid}) async {
    final docUser = FirebaseFirestore.instance.collection('Users').doc(uid);
    final user = User(id: uid, email: email, name: name);
    final jsonUser = user.toJson();
    await docUser.set(jsonUser);
  }

  static Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('Users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromMap(doc.data())).toList());
}
