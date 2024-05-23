import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/category_controller.dart';
import 'package:waste_not/controllers/home.dart';
import 'package:waste_not/controllers/product_controller.dart';
import 'package:waste_not/views/product.dart';

class ProductTile extends StatelessWidget {
  final ProductController productController;
  final HomeController homeController;

  const ProductTile({
    super.key,
    required this.homeController,
    required this.productController,
  });

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController = Get.find();

    return Obx(
      () => ListTile(
        title: Text(productController.product.value?.name ?? "[Name]"),
        subtitle: Text(getCategoryName(productController.product.value?.category, categoryController) ?? "[Category]"),
        leading: Icon(
          homeController.markedProducts.contains(productController.productId)
              ? Icons.check_circle_rounded
              : Icons.add,
        ),
        trailing: Text(
          "expires in ${getDaysUntilExpiration(productController.product.value?.expirationDate)} days",
        ),
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

  String? getCategoryName(String? categoryId, CategoryController categoryController) {
    if (categoryId == null) {
      return null;
    }
    final category = categoryController.categories.firstWhereOrNull((c) => c.id == categoryId);
    return category?.name ?? 'Unknown';
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
