import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/home.dart';
import 'package:waste_not/views/product.dart';

import '../../controllers/product_controller.dart';

class ProductTile extends StatelessWidget {
  final ProductController productController;
  final HomeController homeController;

  const ProductTile(
      {super.key,
      required this.homeController,
      required this.productController});

  @override
  Widget build(BuildContext context) {
    Get.put(productController);
    Get.put(homeController);

    return Obx(
      () => ListTile(
          title: Text(productController.product.value?.name ?? "[Name]"),
          subtitle: Text(productController.product.value?.category.toString() ??
              "[Category]"), // TODO: product category name
          leading: Icon(homeController.markedProducts
                  .contains(productController.productId)
              ? Icons.check_circle_rounded
              : Icons.add), // TODO: get the right icon
          trailing: Text(
              "expires in ${productController.product.value?.expirationDate ?? "#"} days"), // TODO: expiration date
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductView(
                    productController: productController,
                  ))),
          onLongPress: () {
            homeController.switchMarkedProduct(productController.productId);
          }),
    );
  }
}
