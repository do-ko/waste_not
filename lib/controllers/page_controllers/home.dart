import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<String> markedProducts = (<String>[]).obs;

  void switchMarkedProduct(String productId) {
    if (markedProducts.contains(productId)) {
      markedProducts.remove(productId);
    } else {
      markedProducts.add(productId);
    }
  }

  void clear() {
    markedProducts.clear();
  }
}
