import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../model_controllers/product.dart';
import '../model_controllers/products.dart';

class ProductPageController extends GetxController {
  final String productId;
  final ProductsController productsController = Get.find();
  late final ProductController? productController;

  ProductPageController({this.productId = ''});

  @override
  void onInit() {
    super.onInit();
    try {
      productController = productsController.products
          .firstWhereOrNull((product) => product.productId == productId);
      Get.put(productController, tag: productId);
      if (kDebugMode) {
        print(productController?.productId);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error initializing productController: $e");
      }
    }
  }
}
