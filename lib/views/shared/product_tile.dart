import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/home.dart';
import 'package:waste_not/views/product.dart';
import '../../controllers/product.dart';

class ProductTile extends StatelessWidget {
  final ProductController productController;
  final HomeController homeController;

  const ProductTile({
    Key? key,
    required this.homeController,
    required this.productController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(productController);
    Get.put(homeController);

    return Obx(
      () => ListTile(
        title: Text(productController.product.value?.name ?? "[Name]"),
        subtitle: Text(getCategoryName(productController.product.value?.category) ??
            "[Category]"), // TODO: product category name
        leading: Icon(
          homeController.markedProducts.contains(productController.productId)
              ? Icons.check_circle_rounded
              : Icons.add,
        ), // TODO: get the right icon
        trailing: Text(
          "expires in ${getDaysUntilExpiration(productController.product.value?.expirationDate)} days",
        ), // TODO: expiration date
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductView(
            productController: productController,
          ),
        )),
        onLongPress: () {
          homeController.switchMarkedProduct(productController.productId);
        },
      ),
    );
  }

  String? getCategoryName(int? category) {
    // Implement your logic to convert category id to category name
    // For example, you could have a map or a switch statement
    // to convert category id to human-readable category name.
    // This is a placeholder implementation:
    if (category == null) {
      return null;
    }
    switch (category) {
      case 1:
        return 'Dairy';
      case 2:
        return 'Fruits';
      case 3:
        return 'Vegetables';
      // Add more cases as needed
      default:
        return 'Unknown';
    }
  }

  String getDaysUntilExpiration(DateTime? expirationDate) {
    if (expirationDate == null) {
      return "#";
    }
    final now = DateTime.now();
    final difference = expirationDate.difference(now).inDays;
    return difference.toString();
  }
}