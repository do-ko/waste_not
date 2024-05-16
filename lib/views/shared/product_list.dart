import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/views/shared/product_tile.dart';

import '../../controllers/products.dart';

class ProductList extends StatelessWidget {
  final ProductsController productsController;
  ProductList({super.key, required this.productsController});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        children: List.generate(
            productsController.products.length,
            (index) =>
                //Text(index.toString()))); //
                ProductTile(
                    productController: productsController.products[index]))));
  }
}
