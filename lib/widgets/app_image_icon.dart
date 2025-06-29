import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class AppImageIcon extends StatelessWidget {
  const AppImageIcon({
    super.key,
    required this.imagePath,
    required this.foregroundColor,
  });
  final String imagePath;
  final Color foregroundColor;
  @override
  Widget build(BuildContext context) {
    if (imagePath.endsWith('.svg')) {
      return SvgPicture.asset(
        imagePath,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          foregroundColor,
          BlendMode.srcIn,
        ),
      );
    }
    return Image.asset(
      imagePath,
      width: 24,
      height: 24,
    );
  }
}
