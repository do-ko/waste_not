import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/controllers/product.dart';

class ProductsController extends GetxController {
  RxList<ProductController> products = (<ProductController>[]).obs;

  ProductsController() {
    String userId = GetStorage().read("userId") ?? "0";

    products = getProducts(userId).obs;
  }

  List<ProductController> getProducts(String userId) {
    List<String> productIds = []; // TODO get from firebase

    if (kDebugMode) {
      productIds = ["1", "2", "3"];
    }

    return productIds.map((productId) => getProduct(productId)).toList();
  }

  ProductController getProduct(String productId) {
    return ProductController(productId: productId);
  }
}
