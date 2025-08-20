import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/constants/string_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:chillflix_app/product/widgets/custom_app_bar.dart';
import 'package:chillflix_app/views/home/widgets/appbar_icon_buttons.dart';
import 'package:flutter/material.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: StringConstants.newAndPopular,
          actions: [
            AppBarIconButton(icon: Icons.cast, onPressed: () {}),
            AppBarIconButton(icon: Icons.download, onPressed: () {}),
            AppBarIconButton(icon: Icons.search, onPressed: () {}),
          ],
        ),
        SizedBox(
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            children: [
              _buildCategoryButton("🎬", StringConstants.comingSoon, () {}),
              const SizedBox(width: 8),
              _buildCategoryButton(
                  "🔥", StringConstants.watchingEveryoneThese, () {}),
              const SizedBox(width: 8),
              _buildCategoryButton("📺", StringConstants.topTenSeries, () {}),
              const SizedBox(width: 8),
              _buildCategoryButton("🎥", StringConstants.topTenFilms, () {}),
            ],
          ),
        ),
      ],
    );
  }

  /// 🔒 Sadece bu sayfada kullanılan özel buton
  Widget _buildCategoryButton(
      String? emoji, String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: ColorConstants.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: ColorConstants.greyColor),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (emoji != null)
            Text("$emoji ", style: const TextStyle(fontSize: 16)),
          Text(
            text,
            style: AppTextStyles.buttonStyle(),
          ),
        ],
      ),
    );
  }
}
