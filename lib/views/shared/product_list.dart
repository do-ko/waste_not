import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/views/shared/product_tile.dart';

import '../../controllers/product_controller.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find();
    productController.fetchProductsForUser();

    return Obx(() {
      return Container(
          height: double.maxFinite,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SingleChildScrollView(
              child: Column(
                  children: productController.products.isEmpty
                      ? [const Center(child: Text("No products found"))]
                      : productController.products
                          .map((product) => ProductTile(product: product))
                          .toList()),
            ),
          ));
    });

    // return Obx(() {
    //   if (productController.products.isEmpty) {
    //     return const Center(child: Text("No products found"));
    //   }
    //   return ListView.builder(
    //     itemCount: productController.products.length,
    //     itemBuilder: (context, index) {
    //       ProductModel product = productController.products[index];
    //       return ProductTile(product: product, productIndex: index);
    //     },
    //   );
    // });
  }
}
