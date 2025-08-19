import 'package:chillflix_app/product/constants/assets_constants.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/constants/string_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:chillflix_app/views/home/widgets/appbar_icon_buttons.dart';
import 'package:chillflix_app/views/home/widgets/category_buttons.dart';
import 'package:chillflix_app/views/home/widgets/banner_action_buttons.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ekran boyutlarını alıyoruz
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorConstants.blackColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: ColorConstants.blackColor,
          child: SafeArea(
            child: AppBar(
              title: Text(
                'Tuna için',
                style: AppTextStyles.appbarStyle(
                  fontSize: screenWidth * 0.06, 
                  color: ColorConstants.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: ColorConstants.blackColor,
              actions: [
                AppBarIconButton(icon: Icons.cast, onPressed: () {}),
                AppBarIconButton(icon: Icons.download, onPressed: () {}),
                AppBarIconButton(icon: Icons.search, onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            // Category Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CategoryButtons(text: StringConstants.series, onPressed: () {}),
                SizedBox(width: screenWidth * 0.02),
                CategoryButtons(text: StringConstants.films, onPressed: () {}),
                SizedBox(width: screenWidth * 0.02),
                CategoryButtons(
                  text: StringConstants.categories,
                  icon: Icons.keyboard_arrow_down,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            // Banner
            SizedBox(
              height: screenHeight * 0.58, 
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    screenWidth * 0.04),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        AssetsConstants.banner,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.04,
                      right: screenWidth * 0.04,
                      bottom: screenHeight * 0.01,
                      child: BannerActionButtons(
                        onPlayPressed: () {},
                        onMyListPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
