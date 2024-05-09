import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waste_not/views/product.dart';

import '../../controllers/product.dart';
import '../../models/product.dart';

class ProductTile extends ConsumerStatefulWidget {
  final ProductController productController;

  const ProductTile({super.key, required this.productController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductTileState();
}

class _ProductTileState extends ConsumerState<ProductTile> {
  Product? product;
  late bool marked;

  @override
  void initState() {
    super.initState();
    marked = false;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(ChangeNotifierProvider((ref) => widget.productController));
    product = widget.productController.product;

    return ListTile(
      title: Text(product?.name ?? "[Name]"),
      subtitle: Text(product?.category.toString() ??
          "[Category]"), // TODO: product category name
      leading: Icon(marked
          ? Icons.check_circle_rounded
          : Icons.add), // TODO: get the right icon
      trailing: Text(
          "expires in ${product?.expirationDate ?? "#"} days"), // TODO: expiration date
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductView(
                productController: widget.productController,
              ))),
      onLongPress: () => setState(() {
        marked = !marked;
      }),
    );
  }
}
