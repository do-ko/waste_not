import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/auth_controller.dart';
import 'package:waste_not/models/product.dart';

class ProductController extends GetxController {
  RxList<ProductModel> products = RxList<ProductModel>();

  @override
  void onReady() {
    super.onReady();
    fetchProductsForUser();
  }

  Future<void> fetchProductsForUser() async {
    String? currentUserId = AuthController.instance.authUser?.uid;

    if (currentUserId == null) {
      if (kDebugMode) {
        print("User is not logged in");
      }
      return;
    }

    DocumentReference ownerRef =
        FirebaseFirestore.instance.doc('Users/$currentUserId');

    try {
      if (kDebugMode) {
        print(currentUserId);
      }

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('owner', isEqualTo: ownerRef)
          .get();
      if (snapshot.docs.isEmpty) {
        if (kDebugMode) {
          print('No products found for the current user.');
          if (kDebugMode) {
            products.assignAll([1, 2, 3, 4, 5].map((i) => ProductModel(
                productId: i.toString(),
                name: 'Product $i',
                category: 'Category $i',
                comment: 'Hello $i',
                expirationDate: DateTime.now().add(Duration(hours: i + 3)),
                imageLink: '',
                owner: currentUserId)));
          }
        }
      } else {
        if (kDebugMode) {
          print('${snapshot.docs.length} products found.');
        }

        List<ProductModel> productsList = snapshot.docs
            .map((doc) =>
                ProductModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        products.assignAll(productsList);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch products: $e');
      }
    }
  }

  ProductModel? getProduct(String productId) {
    return products.firstWhereOrNull((pc) => pc.productId == productId);
  }

  bool removeProduct(productId) {
    ProductModel? p = getProduct(productId);

    if (p != null) {
      products.remove(p);
      // TODO:remove in Firebase

      return true;
    }

    return false;
  }

  bool removeProducts(List<String> productIds) {
    bool success = true;
    for (String id in productIds) {
      success &= removeProduct(id);
    }
    return success;
  }

  static Future<String?> getDownloadURL(String gsUrl) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(gsUrl);
      final url = await ref.getDownloadURL();
      if (kDebugMode) {
        print(url);
      }
      return url;
    } catch (e) {
      if (kDebugMode) {
        print('Error obtaining download URL: $e');
      }
      return null;
    }
  }
}
