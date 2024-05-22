import 'package:flutter/material.dart';
import 'package:waste_not/controllers/product_controller_old.dart';

import '../controllers/product_controller.dart';

class EditProductView extends StatelessWidget {
  final ProductController productController;
  const EditProductView({super.key, required this.productController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Edit product')),
        body: const Placeholder());
  }
}
