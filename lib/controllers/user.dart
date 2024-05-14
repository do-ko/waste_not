import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserController extends ChangeNotifier {
  User? getUser(int userId) {
    return null;
  }

  static Future createUser({required String email, required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('Users').doc();

    final user = User(id:docUser.id, email: email, name: name);
    final jsonUser = user.toJson();
    await docUser.set(jsonUser);
  }

  static Stream<List<User>> readUsers() => FirebaseFirestore.instance.collection('Users')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => User.fromMap(doc.data())).toList());
}
