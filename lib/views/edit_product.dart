import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waste_not/views/shared/category_button.dart';
import 'package:waste_not/views/shared/theme.dart';

import '../controllers/model_controllers/category.dart';
import '../controllers/shared/add_or_edit_product.dart';
import '../controllers/shared/validator.dart';

class EditProductView extends StatelessWidget {
  const EditProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final String productId = Get.parameters['productId'] ?? 'Default Value';
    final AddOrEditProductController editProductController =
        Get.put(AddOrEditProductController(productId: productId));
    final CategoryController categoryController = Get.find();


    void presentDatePicker() async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: editProductController.selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
      );
      if (picked != null &&
          picked != editProductController.selectedDate.value) {
        editProductController.selectedDate.value = picked;
        editProductController.dateController.text =
            DateFormat('MM/dd/yyyy').format(picked);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.check,
                size: 24,
              ),
              onPressed: () {
                editProductController.updateProduct();
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
                  () => Container(
                width: double.maxFinite,
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: editProductController.image.value != null
                          ? FileImage(File(editProductController.image.value!.path))
                      as ImageProvider
                          : const AssetImage(
                          'assets/placeholder_product_image.jpg'),
                      fit: BoxFit.cover,
                    )),
                child: ElevatedButton(
                  onPressed: () {
                    editProductController.pickImage("product_image");
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: primaryBlue.withOpacity(0.7),
                    backgroundColor: Colors.white.withOpacity(0.7),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(5),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 50,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
              child: Column(
                children: [
                  Form(
                    key: editProductController.productFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: editProductController.nameController,
                          validator: (value) =>
                              CustomValidator.validateFieldNotEmpty(
                                  "Name", value),
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
                          controller: editProductController.dateController,
                          validator: (value) =>
                              CustomValidator.validateFieldNotEmpty(
                                  "Date", value),
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
                            onPressed: () {
                              editProductController.pickImage("date_reading");
                            },
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
                        color:
                        editProductController.categoryId.value ==
                            category.id
                            ? selectedCategory
                            : Colors.white,
                        onPressed: () {
                          // Handle category selection
                          // print("Selected: ${category.name}");
                          editProductController.categoryId.value =
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
