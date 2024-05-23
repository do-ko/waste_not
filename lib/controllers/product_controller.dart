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
      print('Failed to fetch products: $e');
    }
  }

  Future<void> addProduct(ProductModel product) async {
    var collectionRef = FirebaseFirestore.instance.collection('Products');
    try {
      var documentRef = await collectionRef.add(product.toJson());
      product.productId = documentRef.id;
      await documentRef.update({'productId': documentRef.id});
      products.add(product);
      print('Product added and list updated');
    } catch (e) {
      print('Failed to add product: $e');
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    var collectionRef = FirebaseFirestore.instance.collection('Products');
    try {
      await collectionRef.doc(product.productId).update(product.toJson());

      int index = products.indexWhere((p) => p.productId == product.productId);
      if (index != -1) {
        products[index] = product;
      }
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<void> removeProduct(String productId) async {
    var collectionRef = FirebaseFirestore.instance.collection('Products');
    try {
      await collectionRef.doc(productId).delete();
      products.removeWhere((product) => product.productId == productId);
    } catch (e) {
      print('Error removing product: $e');
    }
  }

  Future<void> removeProducts(List<String> productIds) async {
    for (String id in productIds) {
      await removeProduct(id);
    }
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
