import 'package:flutter/widgets.dart';
import 'package:waste_not/controllers/product.dart';

class ProductsController extends ChangeNotifier {
  List<ProductController> getProducts(String userId) {
    List<String> productIds = ["1", "2", "3"]; // TODO get from firebase
    return productIds.map((productId) => getProduct(productId)).toList();
  }

  ProductController getProduct(String productId) {
    return ProductController(productId: productId);
  }
}
