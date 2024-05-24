import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:waste_not/controllers/model_controllers/products.dart';
import 'package:waste_not/controllers/shared/auth.dart';

import '../../models/product.dart';

class AddOrEditProductController extends GetxController {
  final ProductsController productsController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  RxString categoryId = "".obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();
  Rx<XFile?> image = Rx<XFile?>(null);

  Future<void> createAndAddProduct() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible:
          false, // User cannot dismiss the dialog by tapping outside
    );

    if (!productFormKey.currentState!.validate()) {
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

  Future<void> updateProduct() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible:
          false, // User cannot dismiss the dialog by tapping outside
    );

    if (!productFormKey.currentState!.validate()) {
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
    ProductModel updatedProduct = ProductModel(
        name: nameController.text.trim(),
        category: categoryId.value,
        comment: '',
        expirationDate: selectedDate.value,
        imageLink: url,
        owner: AuthController.instance.authUser!.uid);

    // Add the product to Firestore
    await productsController.updateProduct(updatedProduct).catchError((error) {
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

  String reformatDateString(String dateStr) {
    DateFormat inputFormat;
    // Detect the input format based on separators and length
    if (dateStr.contains('-')) {
      if (dateStr.length > 8) {
        inputFormat = DateFormat('dd-MM-yyyy');
      } else {
        inputFormat = DateFormat('dd-MM-yy');
      }
    } else if (dateStr.contains('.')) {
      if (dateStr.length > 8) {
        inputFormat = DateFormat('dd.MM.yyyy');
      } else {
        inputFormat = DateFormat('dd.MM.yy');
      }
    } else {  // Default to slashes
      if (dateStr.length > 8) {
        inputFormat = DateFormat('dd/MM/yyyy');
      } else {
        inputFormat = DateFormat('dd/MM/yy');
      }
    }

    DateTime dateTime = inputFormat.parse(dateStr);
    return DateFormat('MM/dd/yyyy').format(dateTime);
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
    await textRecognizer.processImage(inputImage);
    String textFromImage = recognizedText.text.toString();
    bool dateFound = false;

    RegExp exp = RegExp(
        r'((0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])/(19|20)\d\d)|'  // MM/DD/YYYY
        r'((0[1-9]|1[0-2])\.(0[1-9]|[12][0-9]|3[01])\.(19|20)\d\d)|'  // MM.DD.YYYY
        r'((0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[0-2])\.\d{2})|'  // DD.MM.YY
        r'((0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{2})');  // DD/MM/YY

    if (kDebugMode) {
      print("============================ all text lines");
      print(textFromImage);
    }


    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        RegExpMatch? match = exp.firstMatch(line.text);
        if (match != null) {
          String foundDate = match.group(0)!;
          String formattedDate = reformatDateString(foundDate);

          if (kDebugMode) {
            print("======================================== found date!");
            print(foundDate);
            print(formattedDate);
          }

          DateFormat format = DateFormat('MM/dd/yyyy');
          selectedDate.value = format.parse(formattedDate);
          dateController.text = formattedDate.trim();

          dateFound = true;
          break;
        }
      }
      if (dateFound) {
        break;
      }
    }

    if (!dateFound) {
      if (kDebugMode) {
        print("No date found in the text.");
      }
      Get.snackbar("Error", "No date found in the text.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
