import 'package:chillflix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/constants/assets_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';

class FilmCardSection extends StatelessWidget {
  final Map<String, String> category;
  final bool isComingSoon;

  const FilmCardSection(
      {super.key, required this.category, this.isComingSoon = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "${category['emoji']} ${category['title']}",
              style: AppTextStyles.bodyStyle(
                  fontSize: 20,
                  color: ColorConstants.whiteColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ...List.generate(
              5, (index) => FilmCard(index: index, isComingSoon: isComingSoon)),
        ],
      ),
    );
  }
}

class FilmCard extends StatelessWidget {
  final int index;
  final bool isComingSoon;

  const FilmCard({super.key, required this.index, this.isComingSoon = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: ColorConstants.greyColor.withOpacity(0.5), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              AssetsConstants.banner,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isComingSoon
                      ? "Çok Yakında: Harika Bir Film ${index + 1}"
                      : "Film ${index + 1}",
                  style: AppTextStyles.bodyStyle(
                      fontSize: 18,
                      color: ColorConstants.whiteColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Bu filmde büyük bir macera seni bekliyor. "
                  "Aksiyon, dram ve heyecanın birleştiği unutulmaz sahneler!",
                  style:
                      AppTextStyles.bodyStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                isComingSoon
                    ? _buildReminderButton(context)
                    : _buildPlayAndListButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.notifications_none,
          color: ColorConstants.blackColor, size: 24),
      label: Text(
        S.of(context).remindMe,
        style: AppTextStyles.buttonStyle(
            color: ColorConstants.blackColor, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.whiteColor,
        foregroundColor: ColorConstants.blackColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }

  Widget _buildPlayAndListButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon:
                const Icon(Icons.play_arrow, color: ColorConstants.blackColor),
            label: Text(
              S.of(context).play,
              style: AppTextStyles.buttonStyle(
                  color: ColorConstants.blackColor,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.whiteColor,
              foregroundColor: ColorConstants.blackColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, color: ColorConstants.blackColor),
          label: Text(
            S.of(context).myList,
            style: AppTextStyles.buttonStyle(
                color: ColorConstants.blackColor, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.whiteColor,
            foregroundColor: ColorConstants.blackColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ],
    );
  }
}
