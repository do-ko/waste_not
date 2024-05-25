import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waste_not/views/shared/theme.dart';

class IconAndTextFloat extends StatelessWidget {
  final String iconPath;
  final String headingText;
  final String? subheadingText;
  final bool center;

  const IconAndTextFloat(
      {super.key,
      required this.iconPath,
      required this.headingText,
      this.subheadingText,
      this.center = true});

  @override
  Widget build(BuildContext context) {
    return Center(
        heightFactor: center ? 1.5 : 1.0,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: SvgPicture.asset(iconPath,
                          width: 140,
                          height: 140,
                          fit: BoxFit.contain,
                          colorFilter: const ColorFilter.mode(
                              categoryIconDarkColor, BlendMode.srcIn))),
                  Text(headingText,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: textHeaderColor)),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(subheadingText ?? "",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: fontColorLight))),
                ]))));
  }
}
