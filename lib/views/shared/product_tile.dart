import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/category_controller.dart';
import 'package:waste_not/controllers/home.dart';
import 'package:waste_not/models/product.dart';

import '../../controllers/product_controller.dart';
import '../product.dart';

class ProductTile extends StatelessWidget {
  ProductModel product;

  ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final CategoryController categoryController = Get.find();
    // final ProductController productController = Get.find();

    // return Obx(
    //   () => ListTile(
    //       title: Text(product.name ?? "[Name]"),
    //       subtitle: Text(product.category.toString() ?? "[Category]"),
    //       // TODO: product category name
    //       leading: Icon(
    //           homeController.markedProducts.contains(product.productId)
    //               ? Icons.check_circle_rounded
    //               : Icons.add),
    //       // TODO: get the right icon
    //       trailing: Text(
    //           "expires in ${product.expirationDate.difference(DateTime.now()).inDays.toString() ?? "#"} days"),
    //       // TODO: expiration date
    //       onTap: () => Navigator.of(context).push(MaterialPageRoute(
    //           builder: (context) => ProductView(
    //                 product: product,
    //               ))),
    //       onLongPress: () {
    //         homeController.switchMarkedProduct(product.productId);
    //       },
    //     tileColor: Colors.red,
    //   ),
    // );
    return Obx(() => InkWell(
          onTap: () => Get.to(ProductView(product: product)),
          onLongPress: () =>
              homeController.switchMarkedProduct(product.productId),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            // margin: EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Icon(homeController.markedProducts.contains(product.productId)
                    ? Icons.check_circle_rounded
                    : Icons.add),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(categoryController.getCategoryById(product.category)!.name,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(product.name,
                          style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                ),
                Text(
                    'expires in ${product.expirationDate.difference(DateTime.now()).inDays.toString()} days'),
                SizedBox(width: 10),
                // Icon(Icons.check_circle_outline, color: Colors.green), // Checkbox-like icon
              ],
            ),
          ),
        ));
  }
}
