import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waste_not/controllers/product.dart';

import '../models/product.dart';

class ProductView extends ConsumerWidget {
  final ProductController productController;
  const ProductView({super.key, required this.productController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(ChangeNotifierProvider((ref) => productController));
    Product? product = productController.product;

    return Scaffold(
        appBar: AppBar(title: Text("Product")),
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
