import 'package:flutter/material.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/constants/string_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';

class BannerActionButtons extends StatelessWidget {
  final VoidCallback onPlayPressed;
  final VoidCallback onMyListPressed;

  const BannerActionButtons({
    super.key,
    required this.onPlayPressed,
    required this.onMyListPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.whiteColor,
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: onPlayPressed,
            icon: const Icon(
              Icons.play_arrow,
              color: ColorConstants.blackColor,
              size: 28,
            ),
            label: Text(
              StringConstants.play,
              style:
                  AppTextStyles.buttonStyle(color: ColorConstants.blackColor),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.greyColor,
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: onMyListPressed,
            icon: const Icon(
              Icons.add,
              color: ColorConstants.whiteColor,
              size: 28,
            ),
            label: Text(
              StringConstants.myList,
              style:
                  AppTextStyles.buttonStyle(color: ColorConstants.whiteColor),
            ),
          ),
        ),
      ],
    );
  }
}
