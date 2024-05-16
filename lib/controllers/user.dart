import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserController extends ChangeNotifier {
  UserModel? getUser(int userId) {
    return null;
  }

  static Future createUser({required String email, required String name, required String uid}) async {
    final docUser = FirebaseFirestore.instance.collection('Users').doc(uid);
    final user = UserModel(id: uid, email: email, username: name);
    final jsonUser = user.toJson();
    await docUser.set(jsonUser);
  }

  static Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance.collection('Users')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList());
}
