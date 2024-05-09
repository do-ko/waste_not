import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waste_not/controllers/product.dart';
import 'package:waste_not/views/shared/product_tile.dart';

import '../../controllers/products.dart';

class ProductList extends ConsumerStatefulWidget {
  final ProductsController productsController;
  const ProductList({super.key, required this.productsController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  List<ProductController> products = [];

  @override
  void initState() {
    // TODO: implement initState
    // get products from firebase
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(ChangeNotifierProvider((ref) => widget.productsController));
    products =
        widget.productsController.getProducts("0"); // TODO: use current user id

    return Column(
        children: List.generate(
            products.length,
            (index) =>
                //Text(index.toString()))); //
                ProductTile(productController: products[index])));
  }
}
