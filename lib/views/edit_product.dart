import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waste_not/controllers/product.dart';

class EditProductView extends ConsumerWidget {
  final ProductController productController;
  const EditProductView({super.key, required this.productController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text('Edit product')),
        body: const Placeholder());
  }
}
