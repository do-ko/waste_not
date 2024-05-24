import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waste_not/views/shared/theme.dart';

class CategoryIcon extends StatelessWidget {
  final String? iconPath;
  final double size;
  final double padding;
  final bool darkBackground;
  final bool faded;
  final bool withShadow;

  final placeholderPath = 'assets/placeholder.svg';

  const CategoryIcon(
      {super.key,
      required this.iconPath,
      this.size = 15,
      this.padding = 15,
      this.darkBackground = true,
      this.faded = false,
      this.withShadow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size + padding * 2,
      width: size + padding * 2,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: darkBackground
            ? categoryIconDarkBackgroundColor
            : categoryIconLightBackgroundColor,
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // Shadow position
                ),
              ]
            : null,
      ),
      child: SvgPicture.asset(iconPath ?? placeholderPath,
          width: size,
          height: size,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
              (darkBackground ? categoryIconLightColor : categoryIconDarkColor)
                  .withAlpha(faded ? 100 : 255),
              BlendMode.srcIn)),
    );
  }
}
