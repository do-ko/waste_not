import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:waste_not/controllers/product.dart';

class ProductsController extends GetxController {
  List<ProductController> products = [];

  List<ProductController> getProducts(String userId) {
    List<String> productIds = ["1", "2", "3"]; // TODO get from firebase
    return productIds.map((productId) => getProduct(productId)).toList();
  }

  ProductController getProduct(String productId) {
    return ProductController(productId: productId);
  }
}
