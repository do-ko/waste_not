import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:waste_not/controllers/category_controller.dart';
import 'package:waste_not/views/shared/theme.dart';

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

    return Container(
      width: tileVersion ? 35 : 80,
      height: tileVersion ? 35 : 80,
      padding: EdgeInsets.all(tileVersion ? 5 : 20),
      decoration: BoxDecoration(
        color: tileVersion
            ? categoryIconLightBackgroundColor
            : categoryIconDarkBackgroundColor, // Color of the circle container
        shape: BoxShape.circle, // Makes the container circular
        boxShadow: tileVersion
            ? null
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // Shadow position
                ),
              ],
      ),
      child: SvgPicture.asset(
          categoryController.getCategoryById(categoryId)?.iconPath ??
              'placeholder.svg',
          width: tileVersion ? 30 : 50,
          height: tileVersion ? 30 : 50,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
              tileVersion
                  ? categoryIconDarkColor.withAlpha(marked ? 100 : 255)
                  : categoryIconLightColor,
              BlendMode.hue)),
    );
  }
}
