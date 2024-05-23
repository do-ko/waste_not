import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/controllers/model_controllers/product.dart';

import '../../models/product.dart';
import '../page_controllers/auth.dart';

class ProductsController extends GetxController {
  RxList<ProductController> products = <ProductController>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final deviceStorage = GetStorage();

  // ProductsController() {
  //   String userId = deviceStorage.read("userId") ?? "0";
  //   fetchProducts();
  // }

  @override
  void onReady() {
    super.onReady();
    fetchProducts();
    //fetchProductsForUser();
  }

  Future<void> fetchProducts() async {
    String? userId = AuthController.instance.authUser?.uid ?? '';

    if (userId == null) {
      if (kDebugMode) {
        print("User is not logged in");
      }
      return;
    }

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Users')
          .doc(userId)
          .collection('Products')
          .get();

      List<ProductController> loadedProducts = snapshot.docs.map((doc) {
        return ProductController(productId: doc.id);
      }).toList();

      products.assignAll(loadedProducts);

      if (products.isEmpty) {
        if (kDebugMode) {
          products.assignAll([1, 2, 3, 4, 5]
              .map((i) => ProductController(productId: i.toString())));
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
    }
  }

  // Future<void> fetchProductsForUser() async {
  //   String? currentUserId = AuthController.instance.authUser?.uid;
  //
  //   if (currentUserId == null) {
  //     if (kDebugMode) {
  //       print("User is not logged in");
  //     }
  //     return;
  //   }
  //
  //   DocumentReference ownerRef =
  //   FirebaseFirestore.instance.doc('Users/$currentUserId');
  //
  //   try {
  //     if (kDebugMode) {
  //       print(currentUserId);
  //     }
  //
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('Products')
  //         .where('owner', isEqualTo: ownerRef)
  //         .get();
  //     if (snapshot.docs.isEmpty) {
  //       if (kDebugMode) {
  //         print('No products found for the current user.');
  //         if (kDebugMode) {
  //           products.assignAll([1, 2, 3, 4, 5].map((i) => ProductModel(
  //               productId: i.toString(),
  //               name: 'Product $i',
  //               category: 'Category $i',
  //               comment: 'Hello $i',
  //               expirationDate: DateTime.now().add(Duration(hours: i + 3)),
  //               imageLink: '',
  //               owner: currentUserId)));
  //         }
  //       }
  //     } else {
  //       if (kDebugMode) {
  //         print('${snapshot.docs.length} products found.');
  //       }
  //
  //       List<ProductModel> productsList = snapshot.docs
  //           .map((doc) =>
  //           ProductModel.fromMap(doc.data() as Map<String, dynamic>))
  //           .toList();
  //
  //       products.assignAll(productsList);
  //     }
  //   } catch (e) {
  //     print('Failed to fetch products: $e');
  //   }
  // }

  Future<void> addProduct(ProductModel productModel) async {
    try {
      String? userId = AuthController.instance.authUser?.uid;

      DocumentReference docRef = await _firestore
          .collection('Users')
          .doc(userId)
          .collection('Products')
          .add(productModel.toJson());

      productModel.productId = docRef.id;
      ProductController productController =
          Get.put(ProductController(productId: docRef.id));
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
      String? userId = AuthController.instance.authUser?.uid;
      await _firestore
          .collection('Users')
          .doc(userId)
          .collection('Products')
          .doc(productController.productId)
          .update(productController.product.value!.toJson());

      int index = products
          .indexWhere((p) => p.productId == productController.productId);
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
          .collection('Users')
          .doc(userId)
          .collection('Products')
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
