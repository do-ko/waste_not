import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/views/shared/icon_and_text_float.dart';
import 'package:waste_not/views/shared/product_tile.dart';

import '../../controllers/model_controllers/products.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsController productsController = Get.find();

    return Obx(() {
      return Container(
        height: double.maxFinite,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary, borderRadius: BorderRadius.circular(30)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SingleChildScrollView(
              child: productsController.products.isEmpty
                  ? const IconAndTextFloat(
                      iconPath: "assets/empty_box.svg",
                      headingText: "Your fridge is empty",
                      subheadingText:
                          "Add some products to your fridge\nand save food with WasteNot")
                  : Column(
                      children: productsController.products
                          .where((pc) => pc.product.value != null)
                          .map((pc) => ProductTile(product: pc.product.value!))
                          .toList())),
        ),
      );
    });
  }
}
