import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_not/models/product.dart';

import '../controllers/model_controllers/product.dart';
import '../controllers/model_controllers/products.dart';

class SuggestionsView extends StatelessWidget {
  const SuggestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductsController productsController = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Suggestions')),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => productsController.products.value.length < 3
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.kitchen, size: 100, color: Colors.grey),
                      Text(
                        "No products in your fridge",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Come back after you add some products to your fridge.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      const Text(
                        'Choose three ingredients from your fridge',
                        style: TextStyle(fontSize: 18),
                      ),
                      // SizedBox(height: 20),
                      // Obx(() => DropdownButton<String>(
                      //           value: "Test",
                      //           items: productsController.products.value
                      //               .map((productController) {
                      //             return DropdownMenuItem<String>(
                      //               value: productController.product.value?.productId,
                      //               child: Text(
                      //                   productController.product.value!.name),
                      //             );
                      //           }).toList(),
                      //           onChanged: (String? newProduct) {
                      //             if (ProductModel != null) {
                      //               // languageController.updateLanguage(newValue);
                      //               print(newProduct);
                      //             }
                      //           },
                      //         )
                      //     ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Suggest a recipe'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                      )
                    ],
                  ),
          )
        ],
      )),
    );

    // SingleChildScrollView(
    //     child: Expanded(
    //         child: Center(
    //             child: SvgPicture.asset("assets/placeholder.svg")))));
  }
}
