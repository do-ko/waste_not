import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:waste_not/views/shared/product_tile.dart';
import 'package:waste_not/views/shared/theme.dart';

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
              child: productsController.products.isEmpty
                  ? Center(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Padding(
                                    padding: const EdgeInsets.all(30),
                                    child: SvgPicture.asset(
                                        "assets/empty_box.svg",
                                        width: 140,
                                        height: 140,
                                        fit: BoxFit.contain,
                                        colorFilter: const ColorFilter.mode(
                                            categoryIconDarkColor,
                                            //(darkBackground ? categoryIconLightColor : categoryIconDarkColor)
                                            //.withAlpha(250),
                                            BlendMode.srcIn))),
                                Text("Your fridge is empty",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(color: textHeaderColor)),
                                Text(
                                    "Add some products to your fridge and save food with WasteNot",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: fontColorLight)),
                              ]))))
                  : Column(
                      children: productsController.products
                          .where((pc) => pc.product.value != null)
                          .map((pc) => ProductTile(product: pc.product.value!))
                          .toList())),
        ),
      );
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
