import 'package:get/get.dart';

import '../model_controllers/products.dart';

class ProductController extends GetxController {
  final String productId;
  final ProductsController productsController = Get.find();

  ProductController({this.productId = ''});
}
