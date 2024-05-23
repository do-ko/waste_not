import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:waste_not/models/category.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<CategoryModel> categories = RxList<CategoryModel>();

  @override
  void onReady() {
    super.onReady();
    fetchAllCategories();
  }

  // Future<CategoryModel> getCategoryFromRef(DocumentReference categoryRef) async {
  //   DocumentSnapshot categorySnapshot = await categoryRef.get();
  //   if (categorySnapshot.exists) {
  //     return CategoryModel.fromMap(categorySnapshot.data() as Map<String, dynamic>);
  //   } else {
  //     throw Exception("Category not found!");
  //   }
  // }

  // Future<void> fetchCategoriesFromRefs(
  //     List<DocumentReference> categoryRefs) async {
  //   for (var ref in categoryRefs) {
  //     var snapshot = await ref.get();
  //     if (snapshot.exists) {
  //       categoriesForProducts[ref.id] =
  //           CategoryModel.fromMap(snapshot.data() as Map<String, dynamic>);
  //     }
  //   }
  // }

  void fetchAllCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Categories').get();
      var loadedCategories = querySnapshot.docs
          .map((doc) =>
              CategoryModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      categories.assignAll(loadedCategories);
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  CategoryModel? getCategoryById(String categoryId) {
    return categories.firstWhereOrNull((cat) => cat.categoryId == categoryId);
  }

  Future<void> addCategory(CategoryModel category) async {
    try {
      DocumentReference docRef =
          await _firestore.collection('Categories').add(category.toJson());
      category.categoryId = docRef.id;
      categories.add(category);

      if (kDebugMode) {
        print('Category added with ID: ${category.categoryId}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding category: $e');
      }
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _firestore
          .collection('Categories')
          .doc(category.categoryId)
          .update(category.toJson());

      int index =
          categories.indexWhere((c) => c.categoryId == category.categoryId);
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
      await _firestore.collection('Categories').doc(categoryId).delete();
      categories.removeWhere((category) => category.categoryId == categoryId);
    } catch (e) {
      if (kDebugMode) {
        print('Error removing category: $e');
      }
    }
  }
}
