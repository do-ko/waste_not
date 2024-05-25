import 'package:get/get.dart';
import 'package:waste_not/controllers/model_controllers/products.dart';

class SuggestionsController extends GetxController {
  final List<String> _productNames = <String>[].obs;
  Rx<String?> product0 = null.obs;
  Rx<String?> product1 = null.obs;
  Rx<String?> product2 = null.obs;

  @override
  void onReady() {
    super.onReady();

    ProductsController productsController = Get.find();

    _productNames.assignAll(
        productsController.products.map((pc) => pc.product.value!.name));
    print(_productNames);
  }

  Iterable<String> getProducts(int listPosition) {
    if (listPosition == 0) {
      return _productNames
          .where((p) => p != product1.value && p != product2.value);
    } else if (listPosition == 1) {
      return _productNames
          .where((p) => p != product0.value && p != product2.value);
    } else {
      return _productNames
          .where((p) => p != product0.value && p != product1.value);
    }
  }

  void setChoice(int listPosition, String? product) {
    print("Set $listPosition to $product");
    print("Set $_productNames");
    print("Vals $product0 $product1 $product2");
    if (listPosition == 0) {
      product0 = product.obs;
    } else if (listPosition == 1) {
      product1 = product.obs;
    } else {
      product2 = product.obs;
    }
    print("Vals $product0 $product1 $product2");
  }
}
