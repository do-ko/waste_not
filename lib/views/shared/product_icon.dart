import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waste_not/views/shared/theme.dart';

class ProductIcon extends StatelessWidget {
  final String? iconPath;
  final String? imageLink;
  final double size;
  final double padding;
  final bool darkBackground;
  final bool faded;
  final bool withShadow;

  final placeholderPath = 'assets/placeholder.svg';

  const ProductIcon(
      {super.key,
      this.iconPath,
      this.imageLink,
      this.size = 15,
      this.padding = 8,
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
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: padding * 0.8,
                  blurRadius: padding,
                  offset: Offset(0, padding / 3), // Shadow position
                ),
              ]
            : null,
      ),
      child: imageLink != null
          ? Image.network(
              imageLink!,
              width: size,
              height: size,
              errorBuilder: (c, o, s) =>
                  SvgPicture.asset(placeholderPath, width: size, height: size),
            )
          : SvgPicture.asset(iconPath ?? placeholderPath,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                  (darkBackground
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.tertiary)
                      .withAlpha(faded ? 80 : 255),
                  BlendMode.srcIn)),
    );
  }
}
