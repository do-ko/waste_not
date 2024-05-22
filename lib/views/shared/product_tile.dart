import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/home.dart';
import 'package:waste_not/models/product.dart';
import 'package:waste_not/views/product.dart';

import '../../controllers/product_controller.dart';
import '../../controllers/product_controller_old.dart';

class ProductTile extends StatelessWidget {
  int productIndex;
  ProductModel product;
  ProductTile({super.key, required this.productIndex, required this.product});


  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final ProductController productController = Get.find();
    
    return Obx(
      () => ListTile(
          title: Text(product.name ?? "[Name]"),
          subtitle: Text(product.category.toString() ??
              "[Category]"), // TODO: product category name
          leading: Icon(homeController.markedProducts
                  .contains(product.productId)
              ? Icons.check_circle_rounded
              : Icons.add), // TODO: get the right icon
          trailing: Text(
              "expires in ${product.expirationDate ?? "#"} days"), // TODO: expiration date
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductView(
                    product: product,
                  ))),
          onLongPress: () {
            homeController.switchMarkedProduct(product.productId);
          }),
    );
  }
}
