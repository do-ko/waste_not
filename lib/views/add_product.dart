import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_not/controllers/category_controller.dart';
import 'package:waste_not/controllers/product_controller.dart';
import 'package:waste_not/controllers/products_controller.dart';
import 'package:waste_not/models/product.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();

  final ProductsController productsController = Get.find();
  final CategoryController categoryController = Get.put(CategoryController());

  String? selectedCategory;

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occurred while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    RegExp exp = RegExp(
        r'(\d{2}/\d{2}/\d{4})|(\d{2}.\d{2}.\d{4})|(\d{2}-\d{2}-\d{4})|(\d{4}/\d{2}/\d{2})|(\d{4}.\d{2}.\d{2})|(\d{4}-\d{2}-\d{2})|(\d{2}/\d{2}/\d{2})|(\d{2}.\d{2}.\d{2})|(\d{2}-\d{2}-\d{2})|(\d{2}/\d{4})|(\d{2}.\d{4})|(\d{2}-\d{4})');
    scannedText = "";
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        RegExpMatch? match = exp.firstMatch(line.text);
        if (match != null) {
          String foundDate = match.group(0)!;
          scannedText = scannedText + foundDate + "\n";
          _expirationDateController.text = foundDate; // Automatically fill the expiration date
        }
      }
    }
    textScanning = false;
    setState(() {});
  }

  void addProduct() {
    if (selectedCategory == null) {
      // Show an error message if no category is selected
      Get.snackbar('Error', 'Please select a category');
      return;
    }

    final category = categoryController.categories.firstWhere((c) => c.name == selectedCategory);
    final product = Product(
      name: _nameController.text,
      category: category.id,
      comment: _commentController.text,
      expirationDate: DateTime.parse(_expirationDateController.text),
      imageLink: imageFile?.path ?? '',
      owner: GetStorage().read("userId") ?? 'current_user', // Retrieve actual user ID
    );

    final productController = ProductController(productId: '');
    productController.product.value = product;
    productsController.addProduct(productController);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add Product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_outlined),
            onPressed: addProduct,
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                ),
                Obx(() {
                  if (categoryController.categories.isEmpty) {
                    return const Text('Loading categories...');
                  } else {
                    return DropdownButton<String>(
                      value: selectedCategory,
                      hint: const Text('Select Category'),
                      items: categoryController.categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.name,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    );
                  }
                }),
                TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(labelText: 'Comment'),
                ),
                TextField(
                  controller: _expirationDateController,
                  decoration: const InputDecoration(labelText: 'Expiration Date (YYYY-MM-DD)'),
                ),
                const SizedBox(height: 20),
                if (textScanning) const CircularProgressIndicator(),
                if (!textScanning && imageFile == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                  ),
                if (imageFile != null) Image.file(File(imageFile!.path)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.grey[400],
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.image, size: 30),
                              Text(
                                "Gallery",
                                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.grey[400],
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          getImage(ImageSource.camera);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.camera_alt, size: 30),
                              Text(
                                "Camera",
                                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    scannedText,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}







// import 'dart:io';

// import 'package:flutter/material.dart';
// // import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:waste_not/controllers/product.dart';
// import 'package:waste_not/views/product.dart';

// class AddProductView extends StatefulWidget {
//   const AddProductView({super.key});

//   final String title = 'Add product';

//   @override
//   State<AddProductView> createState() => _AddProductViewState();
// }

// class _AddProductViewState extends State<AddProductView> {
//   bool textScanning = false;

//   XFile? imageFile;

//   String scannedText = "";

//   void getImage(ImageSource source) async {
//     try {
//       final pickedImage = await ImagePicker().pickImage(source: source);
//       if (pickedImage != null) {
//         textScanning = true;
//         imageFile = pickedImage;
//         setState(() {});
//         getRecognisedText(pickedImage);
//       }
//     } catch (e) {
//       textScanning = false;
//       imageFile = null;
//       scannedText = "Error occured while scanning";
//       setState(() {});
//     }
//   }

//   void getRecognisedText(XFile image) async {
//     final inputImage = InputImage.fromFilePath(image.path);
//     final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//     final RecognizedText recognizedText =
//         await textRecognizer.processImage(inputImage);

//     RegExp exp = RegExp(
//         r'(\d{2}/\d{2}/\d{4})|(\d{2}.\d{2}.\d{4})|(\d{2}-\d{2}-\d{4})|(\d{4}/\d{2}/\d{2})|(\d{4}.\d{2}.\d{2})|(\d{4}-\d{2}-\d{2})|(\d{2}/\d{2}/\d{2})|(\d{2}.\d{2}.\d{2})|(\d{2}-\d{2}-\d{2})|(\d{2}/\d{4})|(\d{2}.\d{4})|(\d{2}-\d{4})');
//     // String test = "test string 12/12/24";
//     // RegExpMatch? match = exp.firstMatch(test);
//     // if (match != null) {
//     //   String foundDate = match.group(
//     //       0)!; // Safely extract the matched date (non-null guaranteed by if-check)
//     //   scannedText = scannedText +
//     //       foundDate +
//     //       "\n"; // Append the found date to your result string with a newline
//     //   print(foundDate);
//     //   // print("Date found: $foundDate");  // Optional: output the found date
//     // }
//     scannedText = "";
//     for (TextBlock block in recognizedText.blocks) {
//       for (TextLine line in block.lines) {
//         // Handle each line of text here
//         // scannedText = "";
//         RegExpMatch? match = exp.firstMatch(line.text);
//         if (match != null) {
//           // print(match.pattern);
//           String foundDate = match.group(
//               0)!; // Safely extract the matched date (non-null guaranteed by if-check)
//           scannedText = scannedText +
//               foundDate +
//               "\n"; // Append the found date to your result string with a newline
//           print(foundDate);
//           // print("Date found: $foundDate");  // Optional: output the found date
//         }
//         // scannedText = scannedText + line.text + "\n";
//       }
//     }
//     textScanning = false;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//         actions: [
//           IconButton(
//               icon: const Icon(Icons.check_outlined),
//               onPressed: () {
//                 // TODO: create product in products
//                 Navigator.of(context).pop();
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => ProductView(
//                         productController: ProductController(productId: "0"))));
//               })
//         ],
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               if (textScanning) const CircularProgressIndicator(),
//               if (!textScanning && imageFile == null)
//                 Container(
//                   width: 300,
//                   height: 300,
//                   color: Colors.grey[300]!,
//                 ),
//               if (imageFile != null) Image.file(File(imageFile!.path)),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 5),
//                       padding: const EdgeInsets.only(top: 10),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shadowColor: Colors.grey[400],
//                           elevation: 10,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0)),
//                         ),
//                         onPressed: () {
//                           getImage(ImageSource.gallery);
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 5, horizontal: 5),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(
//                                 Icons.image,
//                                 size: 30,
//                               ),
//                               Text(
//                                 "Gallery",
//                                 style: TextStyle(
//                                     fontSize: 13, color: Colors.grey[600]),
//                               )
//                             ],
//                           ),
//                         ),
//                       )),
//                   Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 5),
//                       padding: const EdgeInsets.only(top: 10),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shadowColor: Colors.grey[400],
//                           elevation: 10,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0)),
//                         ),
//                         onPressed: () {
//                           getImage(ImageSource.camera);
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 5, horizontal: 5),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(
//                                 Icons.camera_alt,
//                                 size: 30,
//                               ),
//                               Text(
//                                 "Camera",
//                                 style: TextStyle(
//                                     fontSize: 13, color: Colors.grey[600]),
//                               )
//                             ],
//                           ),
//                         ),
//                       )),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Text(
//                   scannedText,
//                   style: const TextStyle(fontSize: 20),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
