import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/product.dart';

class ProductList extends ConsumerStatefulWidget {
  final FirebaseApp? firebaseApp;
  const ProductList({super.key, required this.firebaseApp});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  List<Product> products = [];

  @override
  void initState() {
    // TODO: implement initState
    // get products from firebase
    if (widget.firebaseApp != null) {
      // widget.firebaseApp!.get() OR ProductController.getAll() ?
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: List.generate(3, (index) => Text('$index')));
  }
}
