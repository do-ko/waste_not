import 'package:flutter/material.dart';

class EditProductView extends StatelessWidget {
  //final ProductController productController;
  const EditProductView({super.key}); //}, required this.productController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Edit product')),
        body: const Placeholder());
  }
}
