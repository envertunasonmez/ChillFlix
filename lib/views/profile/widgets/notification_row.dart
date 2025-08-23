import 'package:flutter/material.dart';

import 'package:chillflix_app/generated/l10n.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';

import 'package:chillflix_app/views/profile/widgets/circle_icon.dart';

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
          S.of(context).notifications,
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
