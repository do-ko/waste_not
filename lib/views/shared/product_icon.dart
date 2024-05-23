import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/model_controllers/category.dart';
import 'package:waste_not/views/shared/category_icon.dart';

class ProductIcon extends StatelessWidget {
  final String categoryId;
  final bool tileVersion;
  final bool marked;

  const ProductIcon(
      {super.key,
      required this.categoryId,
      this.tileVersion = false,
      this.marked = false});

  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.find();

    return CategoryIcon(
        categoryId: categoryId, tileVersion: tileVersion, marked: marked);
  }
}
