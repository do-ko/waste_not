import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'product.dart';
import '../models/product.dart';

class ProductsController extends GetxController {
  RxList<ProductController> products = <ProductController>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final deviceStorage = GetStorage();

  ProductsController() {
    String userId = deviceStorage.read("userId") ?? "0";
    fetchProducts(userId);
  }

  Future<void> fetchProducts(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('products')
          .get();

      List<ProductController> loadedProducts = snapshot.docs.map((doc) {
        return ProductController(productId: doc.id);
      }).toList();

      products.assignAll(loadedProducts);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
    }
  }

  Future<void> addProduct(ProductController productController) async {
    try {
      String userId = deviceStorage.read("userId") ?? "0";
      DocumentReference docRef = await _firestore
          .collection('users')
          .doc(userId)
          .collection('products')
          .add(productController.product.value!.toJson());

      productController.productId = docRef.id;
      products.add(productController);

      if (kDebugMode) {
        print('Product added with ID: ${productController.productId}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding product: $e');
      }
    }
  }

  Future<void> updateProduct(ProductController productController) async {
    try {
      String userId = deviceStorage.read("userId") ?? "0";
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('products')
          .doc(productController.productId)
          .update(productController.product.value!.toJson());

      int index = products.indexWhere((p) => p.productId == productController.productId);
      if (index != -1) {
        products[index] = productController;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating product: $e');
      }
    }
  }

  Future<void> removeProduct(String productId) async {
    try {
      String userId = deviceStorage.read("userId") ?? "0";
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('products')
          .doc(productId)
          .delete();

      products.removeWhere((product) => product.productId == productId);
    } catch (e) {
      if (kDebugMode) {
        print('Error removing product: $e');
      }
    }
  }

  Future<void> removeProducts(List<String> productIds) async {
    for (String id in productIds) {
      await removeProduct(id);
    }
  }
}