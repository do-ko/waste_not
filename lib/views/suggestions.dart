import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/page_controllers/suggestions.dart';
import 'package:waste_not/views/shared/icon_and_text_float.dart';
import 'package:waste_not/views/shared/product_dropdown.dart';
import 'package:waste_not/views/shared/theme.dart';

import '../controllers/model_controllers/products.dart';

class SuggestionsView extends StatelessWidget {
  const SuggestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    SuggestionsController suggestionsController =
        Get.put(SuggestionsController());
    ProductsController productsController = Get.find();

    return Scaffold(
        appBar: AppBar(title: const Text('Recipe suggestions')),
        body: SingleChildScrollView(
            child: Obx(() => productsController.products.isEmpty
                ? const IconAndTextFloat(
                    iconPath: "assets/recipe.svg",
                    headingText: "No products in your fridge",
                    subheadingText:
                        "Come back after you add\nsome products to your fridge.")
                : Padding(
                    padding: const EdgeInsets.fromLTRB(24, 48, 24, 48),
                    child: Center(
                      child: Column(children: [
                        const IconAndTextFloat(
                            iconPath: "assets/recipe.svg",
                            headingText: "Choose three ingredients",
                            center: false),
                        ProductDropdown(
                            currentValue: suggestionsController.product0.value,
                            values: suggestionsController.getProducts(0),
                            onChanged: (val) =>
                                suggestionsController.setChoice(0, val)),
                        ProductDropdown(
                            currentValue: suggestionsController.product1.value,
                            values: suggestionsController.getProducts(1),
                            onChanged: (val) =>
                                suggestionsController.setChoice(1, val)),
                        ProductDropdown(
                            currentValue: suggestionsController.product2.value,
                            values: suggestionsController.getProducts(2),
                            onChanged: (val) =>
                                suggestionsController.setChoice(2, val)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                            child: FilledButton(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                foregroundColor: fontColorBright,
                                backgroundColor: backgroundDarkColor,
                              ),
                              child: const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text('Suggest a recipe',
                                      style: TextStyle(fontSize: 18))),
                            ))
                      ]),
                    ),
                  ))));
  }
}
