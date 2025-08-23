import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CategoryButtons extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon; // İkon opsiyonel
  final double fontSize;

  const CategoryButtons({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: ColorConstants.greyColor),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      onPressed: onPressed,
      child: icon == null
          ? Text(
              text,
              style: AppTextStyles.buttonStyle(
                fontSize: fontSize,
                color: ColorConstants.whiteColor,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: AppTextStyles.buttonStyle(
                    fontSize: fontSize,
                    color: ColorConstants.whiteColor,
                  ),
                ),
                const SizedBox(width: 4.0),
                Icon(
                  icon,
                  color: ColorConstants.whiteColor,
                ),
              ],
            ),
    );
  }
}
