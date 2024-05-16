import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/views/shared/product_tile.dart';

import '../../controllers/home.dart';
import '../../controllers/products.dart';

class ProductList extends StatelessWidget {
  ProductsController productsController;
  HomeController homeController;
  ProductList(
      {super.key,
      required this.homeController,
      required this.productsController});

  @override
  Widget build(BuildContext context) {
    Get.put(productsController);

    return Obx(() => Column(
        children: productsController.products
            .map((element) => ProductTile(
                homeController: homeController, productController: element))
            .toList()));
  }
}
