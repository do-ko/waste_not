import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/model_controllers/products.dart';
import 'package:waste_not/controllers/page_controllers/auth.dart';

import '../../models/product.dart';

class AddProductController extends GetxController {
  final ProductsController productsController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  RxString categoryId = "".obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();

  Future<void> createAndAddProduct() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible:
          false, // User cannot dismiss the dialog by tapping outside
    );

    if (!addProductFormKey.currentState!.validate()) {
      Get.back();
      return;
    }

    if (categoryId.value == "") {
      Get.back();
      Get.snackbar("Error", "Select a category.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Create a new product
    ProductModel newProduct = ProductModel(
        name: nameController.text.trim(),
        category: categoryId.value,
        comment: '',
        expirationDate: selectedDate.value,
        imageLink: '',
        owner: AuthController.instance.authUser!.uid);

    // Add the product to Firestore
    await productsController.addProduct(newProduct).catchError((error) {
      Get.back();
      Get.snackbar("Error", "Adding product failed.",
          snackPosition: SnackPosition.BOTTOM);
    });

    Get.back();
    Get.back();
    Get.snackbar("Success", "Product was added.",
        snackPosition: SnackPosition.BOTTOM);
  }
}
