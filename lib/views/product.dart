import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:waste_not/controllers/product.dart';
import 'package:waste_not/views/edit_product.dart';

class ProductView extends StatelessWidget {
  final ProductController productController;
  const ProductView({super.key, required this.productController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Product"),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      EditProductView(productController: productController))),
            )
          ],
        ),
        body: Obx(() => Column(
              children: [
                Text(
                    "Image link: ${productController.product?.value.imageLink ?? "[Image link]"}"),
                Text(
                    "Name: ${productController.product?.value.name ?? "[Name]"}"),
                Text(
                    "Expiration date: ${productController.product?.value.imageLink ?? "[Expiration date]"}"),
                Text(
                    "Category: ${productController.product?.value.category ?? "[Category]"}"),
                OutlinedButton.icon(
                    onPressed: () => {},
                    label: const Text("Remove"),
                    icon: const Icon(Icons.remove))
              ],
            )));
  }
}
