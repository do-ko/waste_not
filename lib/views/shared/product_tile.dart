import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/views/product.dart';

import '../../controllers/product.dart';
import '../../models/product.dart';

class ProductTile extends StatefulWidget {
  final ProductController productController;

  const ProductTile({super.key, required this.productController});

  @override
  State<StatefulWidget> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  Product? product;
  late bool marked;

  @override
  void initState() {
    super.initState();
    marked = false;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(widget.productController);

    return Obx(() => ListTile(
          title: Text(widget.productController.product.value?.name ?? "[Name]"),
          subtitle: Text(
              widget.productController.product.value?.category.toString() ??
                  "[Category]"), // TODO: product category name
          leading: Icon(marked
              ? Icons.check_circle_rounded
              : Icons.add), // TODO: get the right icon
          trailing: Text(
              "expires in ${widget.productController.product.value?.expirationDate ?? "#"} days"), // TODO: expiration date
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductView(
                    productController: widget.productController,
                  ))),
          onLongPress: () => setState(() {
            marked = !marked;
          }),
        ));
  }
}
