import 'package:flutter/material.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;

  const CircleIcon({required this.icon, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: ColorConstants.whiteColor, size: 28),
    );
  }
}
