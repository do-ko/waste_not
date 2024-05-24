import 'package:flutter/material.dart';
import 'package:waste_not/views/shared/theme.dart';

import 'category_icon.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final Color color; // Background color for the button
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CategoryIcon(iconPath: iconPath, size: 25, padding: 3),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    color: fontColor, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
