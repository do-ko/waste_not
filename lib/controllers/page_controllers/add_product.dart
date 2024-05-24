import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  Rx<XFile?> image = Rx<XFile?>(null);

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

    final userId = AuthController.instance.authUser?.uid;
    final url = await uploadImage('Users/$userId/Images/', image.value);

    // Create a new product
    ProductModel newProduct = ProductModel(
        name: nameController.text.trim(),
        category: categoryId.value,
        comment: '',
        expirationDate: selectedDate.value,
        imageLink: url,
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

  Future<String> uploadImage(String path, XFile? image) async {
    if (image == null) {
      throw 'No image selected';
    }
    try {
      if (kDebugMode) {
        print("name");
        print(image!.name);
      }
      File file = File(image.path);
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {

      throw 'Image upload failed $e';
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? selectedImage = await picker.pickImage(source: ImageSource.camera);
      if (selectedImage != null) {
        image.value = selectedImage; // Assuming 'image' is an Rx<XFile?>
        if (kDebugMode) {
          print('Image picked: ${selectedImage.path}');
        }
      } else {
        if (kDebugMode) {
          print('No image selected');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
      throw 'Failed to pick image: $e';
    }
  }
}
