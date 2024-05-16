import 'package:get/get.dart';

import '../models/product.dart';

class ProductController extends GetxController {
  final String productId;
  late Rx<Product?> product;

  ProductController({required this.productId}) {
    product = getProduct(productId).obs;
  }

  Product? getProduct(String productId) {
    return Product(
        name: "Product $productId",
        category: -1,
        comment: "Hi",
        expirationDate: DateTime.now(),
        imageLink: "null",
        owner: "0");
  }
}
