import 'package:chillflix_app/product/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'circle_icon.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';

class NotificationRow extends StatelessWidget {
  const NotificationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleIcon(
          icon: Icons.notifications,
          backgroundColor: ColorConstants.redColor,
        ),
        const SizedBox(width: 12),
        Text(
          StringConstants.notifications,
          style: AppTextStyles.bodyStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorConstants.whiteColor,
          ),
        ),
        const Spacer(),
        const Icon(Icons.chevron_right, color: ColorConstants.whiteColor),
      ],
    );
  }
}
