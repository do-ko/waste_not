import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/models/product.dart';

import '../page_controllers/auth.dart';

class ProductController extends GetxController {
  String productId;
  late Rx<ProductModel?> product;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late RxString name;
  late Rx<DateTime> expirationDate;

  ProductController({required this.productId}) {
    product = Rx<ProductModel?>(null);
    name = ''.obs;
    expirationDate = DateTime.now().obs;
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    try {
      String? userId = AuthController.instance.authUser?.uid ?? '';
      DocumentSnapshot doc = await _firestore
          .collection('Users')
          .doc(userId)
          .collection('Products')
          .doc(productId)
          .get();

      if (doc.exists) {
        product.value = ProductModel.fromMap(doc.data() as Map<String, dynamic>);
      } else if (kDebugMode && ["1", "2", "3", "4", "5"].contains(productId)) {
        product.value = ProductModel(
            productId: productId,
            name: 'Product $productId',
            category: 'Category $productId',
            comment: 'Hello $productId',
            expirationDate: DateTime.now().add(Duration(hours: 3)),
            imageLink: '',
            owner: userId);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching product: $e');
      }
    }
  }

  // Future<void> addProduct(ProductModel product) async {
  //   var collectionRef = FirebaseFirestore.instance.collection('Products');
  //   try {
  //     var documentRef = await collectionRef.add(product.toJson());
  //     product.productId = documentRef.id;
  //     await documentRef.update({'productId': documentRef.id});
  //     products.add(product);
  //     print('Product added and list updated');
  //   } catch (e) {
  //     print('Failed to add product: $e');
  //   }
  // }

  Future<void> addProduct(ProductModel newProduct) async {
    try {
      String? userId = AuthController.instance.authUser?.uid ?? '';
      await _firestore
          .collection('Users')
          .doc(userId)
          .collection('Products')
          .add({
        'name': newProduct.name,
        'category': newProduct.category,
        'comment': newProduct.comment,
        'expiration_date': newProduct.expirationDate,
        'image_link': newProduct.imageLink,
        'owner': newProduct.owner,
      });

      product.value = newProduct;
    } catch (e) {
      if (kDebugMode) {
        print('Error updating product: $e');
      }
    }
  }

  // Future<void> updateProduct(ProductModel product) async {
  //   var collectionRef = FirebaseFirestore.instance.collection('Products');
  //   try {
  //     await collectionRef.doc(product.productId).update(product.toJson());
  //
  //     int index = products.indexWhere((p) => p.productId == product.productId);
  //     if (index != -1) {
  //       products[index] = product;
  //     }
  //   } catch (e) {
  //     print('Error updating product: $e');
  //   }
  // }

  Future<void> updateProduct(ProductModel updatedProduct) async {
    try {
      String userId = GetStorage().read("userId") ?? "0";
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('products')
          .doc(productId)
          .update({
        'name': updatedProduct.name,
        'category': updatedProduct.category,
        'comment': updatedProduct.comment,
        'expiration_date': updatedProduct.expirationDate,
        'image_link': updatedProduct.imageLink,
        'owner': updatedProduct.owner,
      });

      product.value = updatedProduct;
    } catch (e) {
      if (kDebugMode) {
        print('Error updating product: $e');
      }
    }
  }


  Future<void> removeProduct() async {
    try {
      String userId = GetStorage().read("userId") ?? "0";
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('products')
          .doc(productId)
          .delete();

      product.value = null;
    } catch (e) {
      if (kDebugMode) {
        print('Error removing product: $e');
      }
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
