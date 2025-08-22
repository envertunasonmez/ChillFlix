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
            _CustomAppBar(),
            SizedBox(height: 24),
            Center(child: ProfileHeader()),
            SizedBox(height: 24),
            NotificationRow(),
            SizedBox(height: 16),
            NotificationItem(
              imagePath: AssetsConstants.banner,
              title: "Film Başlığı",
              genre: "Aksiyon, Macera",
              date: "20 Ağu",
            ),
            SizedBox(height: 32),
            DownloadedRow(),
            SizedBox(height: 32),
            Text(
              StringConstants.likedSeriesAndFilms,
              style: AppTextStyles.bodyStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstants.whiteColor,
              ),
            ),
            SizedBox(height: 16),
            LikedMoviesList(),
          ],
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Benim Netfilix'im",
      actions: [
        AppBarIconButton(icon: Icons.cast, onPressed: () {}),
        AppBarIconButton(icon: Icons.search, onPressed: () {}),
        AppBarIconButton(icon: Icons.menu, onPressed: () {}),
      ],
    );
  }
}
