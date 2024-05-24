import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_not/controllers/model_controllers/products.dart';
import 'package:waste_not/controllers/shared/auth.dart';

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
    final url = image.value != null
        ? await uploadImage('Users/$userId/Images/', image.value)
        : "";

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

  Future<void> pickImage(String purpose) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? selectedImage =
          await picker.pickImage(source: ImageSource.camera);
      if (selectedImage != null) {
        if (purpose == "product_image") {
          // action for taking product image
          image.value = selectedImage;
        } else if (purpose == "date_reading") {
          // action for reading text from image
          getRecognisedText(selectedImage);
        }
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

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String textFromImage = recognizedText.text.toString();

    // RegExp exp = RegExp(
    //     r'(\d{2}/\d{2}/\d{4})|(\d{2}.\d{2}.\d{4})|(\d{2}-\d{2}-\d{4})|(\d{4}/\d{2}/\d{2})|(\d{4}.\d{2}.\d{2})|(\d{4}-\d{2}-\d{2})|(\d{2}/\d{2}/\d{2})|(\d{2}.\d{2}.\d{2})|(\d{2}-\d{2}-\d{2})|(\d{2}/\d{4})|(\d{2}.\d{4})|(\d{2}-\d{4})');

    RegExp exp = RegExp(
        r'');

    if (kDebugMode) {
      print("============================ all text lines");
      print(textFromImage);
    }


    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        RegExpMatch? match = exp.firstMatch(line.text);
        if (match != null) {
          String foundDate = match.group(
              0)!;
          // scannedText = scannedText +
          //     foundDate +
          //     "\n"; // Append the found date to your result string with a newline
          if (kDebugMode) {
            print("======================================== found date!");
            print(foundDate);
          }
          // print("Date found: $foundDate");  // Optional: output the found date
        }
        // scannedText = scannedText + line.text + "\n";
      }
    }

    // String test = "test string 12/12/24";
    // RegExpMatch? match = exp.firstMatch(test);
    // if (match != null) {
    //   String foundDate = match.group(
    //       0)!; // Safely extract the matched date (non-null guaranteed by if-check)
    //   scannedText = scannedText +
    //       foundDate +
    //       "\n"; // Append the found date to your result string with a newline
    //   print(foundDate);
    //   // print("Date found: $foundDate");  // Optional: output the found date
    // }
    // scannedText = "";

    // textScanning = false;
    // setState(() {});
  }
}
