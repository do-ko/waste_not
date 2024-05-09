import 'package:flutter/material.dart';

import '../../controllers/product.dart';

class ProductTile extends StatefulWidget {
  final ProductController productController;

  const ProductTile({super.key, required this.productController});

  @override
  State<StatefulWidget> createState() => _ProductTileState();
}

class _ProductTileState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}
