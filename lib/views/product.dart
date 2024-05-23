import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waste_not/controllers/product_controller.dart';
import 'package:waste_not/views/edit_product.dart';

import '../models/product.dart';

class ProductView extends StatelessWidget {
  final ProductController productController;
  const ProductView({super.key, required this.productController});

  @override
  Widget build(BuildContext context) {
    // ref.watch(ChangeNotifierProvider((ref) => productController));
    Product? product = productController.product.value;

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
        body: Column(
          children: [
            Text("Image link: ${product?.imageLink ?? "[Image link]"}"),
            Text("Name: ${product?.name ?? "[Name]"}"),
            Text(
                "Expiration date: ${product?.imageLink ?? "[Expiration date]"}"),
            Text("Category: ${product?.category ?? "[Category]"}"),
            OutlinedButton.icon(
                onPressed: () => {},
                label: Text("Remove"),
                icon: Icon(Icons.remove))
          ],
        ));
  }
}
