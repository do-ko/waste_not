import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../models/category.dart';

class CategoryController extends GetxController {
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CategoryController() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('categories').get();
      List<CategoryModel> loadedCategories = snapshot.docs.map((doc) {
        return CategoryModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      categories.assignAll(loadedCategories);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching categories: $e');
      }
    }
  }

  Future<void> addCategory(CategoryModel category) async {
    try {
      DocumentReference docRef = await _firestore.collection('categories').add(category.toJson());
      category.id = docRef.id;
      categories.add(category);

      if (kDebugMode) {
        print('Category added with ID: ${category.id}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding category: $e');
      }
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _firestore.collection('categories').doc(category.id).update(category.toJson());

      int index = categories.indexWhere((c) => c.id == category.id);
      if (index != -1) {
        categories[index] = category;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating category: $e');
      }
    }
  }

  Future<void> removeCategory(String categoryId) async {
    try {
      await _firestore.collection('categories').doc(categoryId).delete();
      categories.removeWhere((category) => category.id == categoryId);
    } catch (e) {
      if (kDebugMode) {
        print('Error removing category: $e');
      }
    }
  }
}