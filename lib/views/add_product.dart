import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waste_not/controllers/add_product_controller.dart';
import 'package:waste_not/controllers/validator.dart';
import 'package:waste_not/views/shared/theme.dart';

import '../controllers/category_controller.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final AddProductController addProductController =
        Get.put(AddProductController());
    final CategoryController categoryController = Get.find();

    void presentDatePicker() async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: addProductController.selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
      );
      if (picked != null && picked != addProductController.selectedDate.value) {
        // setState(() {
        //   _selectedDate = picked;
        //   _dateController.text = DateFormat('MM/dd/yyyy').format(picked);
        // });
        addProductController.selectedDate.value = picked;
        addProductController.dateController.text =
            DateFormat('MM/dd/yyyy').format(picked);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.check,
                size: 24,
              ),
              onPressed: () {
                addProductController.createAndAddProduct();
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 200,
              alignment: Alignment.center,
              color: Colors.red,
              child: const CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 48),
              child: Column(
                children: [
                  Form(
                    key: addProductController.addProductFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: addProductController.nameController,
                          validator: (value) =>
                              CustomValidator.validateEmptyText("Name", value),
                          decoration: const InputDecoration(
                            labelText: "Name",
                            labelStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: fontColorBlue),
                            filled: true,
                            fillColor: containerColor,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Choose expiration date",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: addProductController.dateController,
                          validator: (value) =>
                              CustomValidator.validateEmptyText("Date", value),
                          decoration: InputDecoration(
                            labelText: "Date",
                            labelStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: fontColorBlue),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_month),
                              color: primaryBlue,
                              onPressed: presentDatePicker,
                            ),
                            filled: true,
                            fillColor: containerColor,
                            enabledBorder: InputBorder.none,
                          ),
                          readOnly: true,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "or",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: primaryBlue,
                              minimumSize: const Size(180, 36),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Take a photo',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Select category",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(
                    () => Wrap(
                      spacing: 20, // Horizontal space between buttons
                      runSpacing: 20, // Vertical space between buttons
                      children: categoryController.categories
                          .map((category) => CategoryButton(
                                label: category.name,
                                iconPath: category.iconPath,
                                color: addProductController.categoryId.value ==
                                        category.id
                                    ? selectedCategory
                                    : Colors.white,
                                onPressed: () {
                                  // Handle category selection
                                  // print("Selected: ${category.name}");
                                  addProductController.categoryId.value =
                                      category.id;
                                },
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final Color color; // Background color for the button
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: primaryBlue, // Color of the circle container
                shape: BoxShape.circle, // Makes the container circular
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 5,
                //     blurRadius: 7,
                //     offset: const Offset(0, 3), // Shadow position
                //   ),
                // ],
              ),
              child: SvgPicture.asset(iconPath,
                  width: 15, height: 15, fit: BoxFit.contain),
            ),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    color: fontColor, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// // import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:waste_not/controllers/product_controller_old.dart';
// import 'package:waste_not/views/product.dart';
//
// class AddProductView extends StatefulWidget {
//   const AddProductView({super.key});
//
//   final String title = 'Add product';
//
//   @override
//   State<AddProductView> createState() => _AddProductViewState();
// }
//
// class _AddProductViewState extends State<AddProductView> {
//   bool textScanning = false;
//
//   XFile? imageFile;
//
//   String scannedText = "";
//
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
//
//   void getRecognisedText(XFile image) async {
//     final inputImage = InputImage.fromFilePath(image.path);
//     final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//     final RecognizedText recognizedText =
//         await textRecognizer.processImage(inputImage);
//
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
//
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
//               //   Navigator.of(context).push(MaterialPageRoute(
//               //       builder: (context) => ProductView(
//               //           productController: ProductController(productId: "0"))));
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
