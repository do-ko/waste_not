import 'package:flutter/widgets.dart';

import '../models/product.dart';

class ProductController extends ChangeNotifier {
  final String productId;
  Product? product;

  ProductController({required this.productId}) {
    product = getProduct(productId);
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
