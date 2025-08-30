import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  const AppBarIconButton({
    super.key,
    required this.icon,
    this.size = 28.0,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: size,
      icon: Icon(icon, color: ColorConstants.whiteColor),
      onPressed: onPressed,
    );
  }
}
