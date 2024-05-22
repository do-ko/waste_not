import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/views/shared/product_tile.dart';

import '../../controllers/home.dart';
import '../../controllers/product_controller.dart';
import '../../models/product.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  // ProductController productsController;
  // HomeController homeController;
  // ProductList(
  //     {super.key,
  //     required this.homeController,
  //     required this.productsController});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find();
    final HomeController homeController = Get.find();

    // return Obx(() => Column(
    //     children: productController.products
    //         .map((element) => ProductTile(productId: element.productId))
    //         .toList()));

    return Obx(() {
      if (productController.products.isEmpty) {
        return const Center(child: Text("No products found"));
      }
      return Expanded(child: ListView.builder(
        itemCount: productController.products.length,
        itemBuilder: (context, index) {
          ProductModel product = productController.products[index];
          return ProductTile(product: product, productIndex: index);
        },
      ),);
    });
  }
}
