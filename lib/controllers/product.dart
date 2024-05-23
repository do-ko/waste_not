import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/product.dart';

class ProductController extends GetxController {
  String productId;
  late Rx<Product?> product;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late RxString name;
  late Rx<DateTime> expirationDate;

  ProductController({required this.productId}) {
    product = Rx<Product?>(null);
    name = ''.obs;
    expirationDate = DateTime.now().obs;
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    try {
      String userId = GetStorage().read("userId") ?? "0";
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('products')
          .doc(productId)
          .get();

      if (doc.exists) {
        product.value = Product(
          name: doc['name'],
          category: doc['category'],
          comment: doc['comment'],
          expirationDate: doc['expiration_date'].toDate(),
          imageLink: doc['image_link'],
          owner: doc['owner'],
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching product: $e');
      }
    }
  }

  Future<void> updateProduct(Product updatedProduct) async {
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
}