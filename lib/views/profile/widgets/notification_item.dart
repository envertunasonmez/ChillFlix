import 'package:flutter/material.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';

class NotificationItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String genre;
  final String date;

  const NotificationItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.genre,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: ColorConstants.redColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            width: 140,
            height: 90,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: AppTextStyles.bodyStyle(
                      fontSize: 16, color: ColorConstants.whiteColor)),
              const SizedBox(height: 4),
              Text(genre,
                  style: AppTextStyles.bodyStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.greyColor)),
              const SizedBox(height: 4),
              Text(date,
                  style: AppTextStyles.bodyStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: ColorConstants.greyColor)),
            ],
          ),
        ),
      ],
    );
  }
}
