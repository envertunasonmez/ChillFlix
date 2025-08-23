import 'package:chillflix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:chillflix_app/product/constants/assets_constants.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:chillflix_app/views/home/widgets/appbar_icon_buttons.dart';
import 'package:chillflix_app/views/home/widgets/category_buttons.dart';
import 'package:chillflix_app/views/home/widgets/banner_action_buttons.dart';
import 'package:chillflix_app/product/widgets/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // ✅ Scaffold'ı kaldırdık, sadece Column döndürüyoruz
    return Column(
      children: [
        /// ✅ CustomAppBar kullanımı
        CustomAppBar(
          title: 'Tuna için',
          actions: [
            AppBarIconButton(icon: Icons.cast, onPressed: () {}),
            AppBarIconButton(icon: Icons.download, onPressed: () {}),
            AppBarIconButton(icon: Icons.search, onPressed: () {}),
          ],
        ),

        /// ✅ İçerik kısmı Expanded içine aldık
        Expanded(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔹 Üst kısım (Kategori + Banner) → Daha geniş padding
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        _CategoryRow(size: size),
                        SizedBox(height: size.height * 0.02),
                        _BannerWidget(size: size),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

                  /// 🔹 Alt bölümler (Daha az padding)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionTitle(
                            title: S.of(context).mostWanted, size: size),
                        SizedBox(height: size.height * 0.015),
                        _HorizontalMovieList(
                            size: size, itemCount: 10, itemWidthFactor: 0.30),
                        SizedBox(height: size.height * 0.02),
                        _SectionTitle(
                            title: S.of(context).onlyChillflix, size: size),
                        SizedBox(height: size.height * 0.015),
                        _HorizontalMovieList(
                            size: size,
                            itemCount: 10,
                            itemWidthFactor: 0.50,
                            heightFactor: 0.32),
                        SizedBox(height: size.height * 0.02),
                        _SectionTitleWithAction(
                            title: S.of(context).myList, size: size),
                        SizedBox(height: size.height * 0.015),
                        _HorizontalMovieList(
                            size: size, itemCount: 8, itemWidthFactor: 0.30),

                        /// ✅ Alt kısımda biraz boşluk bıraktık (navbar için)
                        SizedBox(height: size.height * 0.02),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 🔹 Kategori Butonları Row
class _CategoryRow extends StatelessWidget {
  const _CategoryRow({required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: CategoryButtons(text: S.of(context).series, onPressed: () {}),
        ),
        SizedBox(width: size.width * 0.02),
        Flexible(
          child: CategoryButtons(text: S.of(context).films, onPressed: () {}),
        ),
        SizedBox(width: size.width * 0.02),
        Flexible(
          child: CategoryButtons(
            text: S.of(context).categories,
            icon: Icons.keyboard_arrow_down,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

/// 🔹 Banner
class _BannerWidget extends StatelessWidget {
  const _BannerWidget({required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.58,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size.width * 0.04),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(AssetsConstants.banner, fit: BoxFit.cover),
            ),
            Positioned(
              left: size.width * 0.04,
              right: size.width * 0.04,
              bottom: size.height * 0.01,
              child: BannerActionButtons(
                onPlayPressed: () {},
                onMyListPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Bölüm Başlığı
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.size});
  final String title;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.bodyStyle(
        fontSize: size.width * 0.05,
        color: ColorConstants.whiteColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/// 🔹 "Başlık + Tümünü Görüntüle" satırı
class _SectionTitleWithAction extends StatelessWidget {
  const _SectionTitleWithAction({required this.title, required this.size});
  final String title;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _SectionTitle(title: title, size: size),
        ),
        InkWell(
          onTap: () => debugPrint("Tümünü Görüntüle tıklandı"),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).seeAll,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 0.035,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                size: size.width * 0.04,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 🔹 Yatay Film Listesi
class _HorizontalMovieList extends StatelessWidget {
  const _HorizontalMovieList({
    required this.size,
    required this.itemCount,
    required this.itemWidthFactor,
    this.heightFactor = 0.20,
  });

  final Size size;
  final int itemCount;
  final double itemWidthFactor;
  final double heightFactor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * heightFactor,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (_, __) => SizedBox(width: size.width * 0.03),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => debugPrint("Film $index tıklandı"),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size.width * 0.02),
              child: Image.asset(
                AssetsConstants.banner,
                width: size.width * itemWidthFactor,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
