import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/views/shared/product_tile.dart';
import '../../controllers/home.dart';
import '../../controllers/products_controller.dart';

class ProductList extends StatelessWidget {
  final ProductsController productsController;
  final HomeController homeController;

  ProductList({
    Key? key,
    required this.homeController,
    required this.productsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productsController.products.isEmpty) {
        return const Center(child: Text('No products to display.'));
      } else {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: productsController.products.length,
          itemBuilder: (context, index) {
            final productController = productsController.products[index];
            return ProductTile(
              homeController: homeController,
              productController: productController,
            );
          },
        );
      }
    });
  }
}