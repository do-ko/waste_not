import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/model_controllers/category.dart';
import 'package:waste_not/controllers/page_controllers/home.dart';
import 'package:waste_not/models/product.dart';
import 'package:waste_not/views/shared/product_icon.dart';
import 'package:waste_not/views/shared/theme.dart';

import '../product.dart';

class ProductTile extends StatelessWidget {
  ProductModel product;

  ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final CategoryController categoryController = Get.find();
    //final ProductController productController = Get.find();
    bool marked = homeController.markedProducts.contains(product.productId);

    return Obx(
      () => ListTile(
        title: Text(
            categoryController.getCategoryById(product.category)?.name ??
                "[Category]",
            style: productTileCategoryStyle
                .merge(Theme.of(context).listTileTheme.subtitleTextStyle)),
        subtitle: Text(product.name ?? "[Name]",
            style: productTileNameStyle.merge(Theme.of(context)
                .listTileTheme
                .titleTextStyle
                ?.merge(productTileNameStyle))),
        leading: Stack(
            alignment: Alignment.center,
            children: <Widget>[
                  ProductIcon(
                      iconPath: categoryController
                          .getCategoryById(product.category)
                          ?.iconPath,
                      size: 35,
                      padding: 5,
                      darkBackground: false,
                      faded: homeController.markedProducts
                          .contains(product.productId)),
                ] +
                (homeController.markedProducts.contains(product.productId)
                    ? [
                        const Icon(Icons.check_circle_rounded,
                            color: iconColor),
                      ]
                    : [])),
        trailing: Text(
            "expires in ${product.expirationDate.difference(DateTime.now()).inDays.toString() ?? "#"} days",
            style: productTileDaysLeftStyle.merge(
                Theme.of(context).listTileTheme.leadingAndTrailingTextStyle)),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductView(
                  product: product,
                ))),
        onLongPress: () {
          homeController.switchMarkedProduct(product.productId);
        },
      ),
    );
    // return Obx(() => InkWell(
    //       onTap: () => Get.to(ProductView(product: product)),
    //       onLongPress: () =>
    //           homeController.switchMarkedProduct(product.productId),
    //       child: Container(
    //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    //         // margin: EdgeInsets.only(left: 25, right: 25),
    //         decoration: const BoxDecoration(
    //           color: Colors.white,
    //         ),
    //         child: Row(
    //           children: [
    //             Icon(homeController.markedProducts.contains(product.productId)
    //                 ? Icons.check_circle_rounded
    //                 : Icons.add),
    //             const SizedBox(width: 10),
    //             Expanded(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                       categoryController
    //                               .getCategoryById(product.category)
    //                               ?.name ??
    //                           '[null]',
    //                       style: const TextStyle(fontWeight: FontWeight.bold)),
    //                   Text(product.name,
    //                       style: TextStyle(color: Colors.grey[700])),
    //                 ],
    //               ),
    //             ),
    //             Text(
    //                 'expires in ${product.expirationDate.difference(DateTime.now()).inDays.toString()} days'),
    //             const SizedBox(width: 10),
    //             // Icon(Icons.check_circle_outline, color: Colors.green), // Checkbox-like icon
    //           ],
    //         ),
    //       ),
    //     ));
  }
}
