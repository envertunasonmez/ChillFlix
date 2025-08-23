import 'package:chillflix_app/product/constants/string_constants.dart';
import 'package:flutter/material.dart';

import 'package:chillflix_app/product/constants/assets_constants.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:chillflix_app/product/widgets/custom_app_bar.dart';
import 'package:chillflix_app/views/home/widgets/appbar_icon_buttons.dart';
import 'package:chillflix_app/views/profile/widgets/downloaded_row.dart';
import 'package:chillflix_app/views/profile/widgets/liked_movies_list.dart';
import 'package:chillflix_app/views/profile/widgets/notification_item.dart';
import 'package:chillflix_app/views/profile/widgets/notification_row.dart';
import 'package:chillflix_app/views/profile/widgets/profile_header.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blackColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _CustomAppBar(),
            const SizedBox(height: 24),
            const Center(child: ProfileHeader()),
            const SizedBox(height: 24),
            const NotificationRow(),
            const SizedBox(height: 16),
            NotificationItem(
              imagePath: AssetsConstants.banner,
              title: "Film Başlığı",
              genre: "Aksiyon, Macera",
              date: "20 Ağu",
            ),
            const SizedBox(height: 32),
            const DownloadedRow(),
            const SizedBox(height: 32),
            Text(
              StringConstants.likedSeriesAndFilms,
              style: AppTextStyles.bodyStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstants.whiteColor,
              ),
            ),
            const SizedBox(height: 16),
            const LikedMoviesList(),
          ],
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar();

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorConstants.blackColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const _ProfileBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Benim Netfilix'im",
      actions: [
        AppBarIconButton(icon: Icons.cast, onPressed: () {}),
        AppBarIconButton(icon: Icons.search, onPressed: () {}),
        AppBarIconButton(
            icon: Icons.menu, onPressed: () => _openBottomSheet(context)),
      ],
    );
  }
}

class _ProfileBottomSheet extends StatelessWidget {
  const _ProfileBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _BottomSheetTile(
            icon: Icons.settings,
            title: "Ayarlar",
          ),
          _BottomSheetTile(
            icon: Icons.person,
            title: "Profilim",
          ),
          _BottomSheetTile(
            icon: Icons.logout,
            title: "Çıkış Yap",
          ),
        ],
      ),
    );
  }
}

class _BottomSheetTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _BottomSheetTile({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: ColorConstants.whiteColor),
      title: Text(
        title,
        style: AppTextStyles.bodyStyle(color: ColorConstants.whiteColor),
      ),
      onTap: () => Navigator.pop(context),
    );
  }
}
