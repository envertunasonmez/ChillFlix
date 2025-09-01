import 'package:flutter/material.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';

class CategoryList extends StatelessWidget {
  final List<Map<String, String>> categories;
  final int selectedIndex;
  final Function(int) onTap;

  const CategoryList({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedIndex == index;
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isSelected ? ColorConstants.greyColor : Colors.transparent,
              foregroundColor: ColorConstants.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: ColorConstants.greyColor),
              ),
            ),
            onPressed: () => onTap(index),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${category['emoji']} ",
                    style: AppTextStyles.buttonStyle(fontSize: 16)),
                Text(category['title']!, style: AppTextStyles.buttonStyle()),
              ],
            ),
          );
        },
      ),
    );
  }
}
