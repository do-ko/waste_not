import 'package:flutter/cupertino.dart';
import 'package:waste_not/controllers/product_controller.dart';

class ProductIcon extends StatelessWidget {
  final ProductController productController;
  final bool marked;

  const ProductIcon(
      {super.key, required this.productController, required this.marked});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
