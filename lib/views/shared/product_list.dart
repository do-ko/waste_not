import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SingleChildScrollView(
              child: Column(
                  children: productsController.products.isEmpty
                      ? [const Center(child: Text("No products found"))]
                      : productsController.products
                          .where((pc) => pc.product.value != null)
                          .map((pc) => ProductTile(product: pc.product.value!))
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
