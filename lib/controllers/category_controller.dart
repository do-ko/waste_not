import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:waste_not/models/category.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  RxList<CategoryModel> categories = RxList<CategoryModel>();
  RxMap<String, CategoryModel> categoriesForProducts =
      RxMap<String, CategoryModel>();

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
          await FirebaseFirestore.instance.collection('Categories').get();
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
}
