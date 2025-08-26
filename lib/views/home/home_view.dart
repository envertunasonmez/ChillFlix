import 'package:chillflix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillflix_app/product/constants/assets_constants.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:chillflix_app/views/home/widgets/appbar_icon_buttons.dart';
import 'package:chillflix_app/views/home/widgets/category_buttons.dart';
import 'package:chillflix_app/views/home/widgets/banner_action_buttons.dart';
import 'package:chillflix_app/product/widgets/custom_app_bar.dart';
import 'package:chillflix_app/cubit/movies/movies_cubit.dart';
import 'package:chillflix_app/product/widgets/film_card.dart';
import 'package:chillflix_app/product/models/movie_model.dart';

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
                        _SectionTitle(title: 'Most Wanted', size: size),
                        SizedBox(height: size.height * 0.015),
                        _HorizontalMovieList(
                            size: size,
                            category: 'most_wanted',
                            itemWidthFactor: 0.30),
                        SizedBox(height: size.height * 0.02),
                        _SectionTitle(title: 'Only on ChillFlix', size: size),
                        SizedBox(height: size.height * 0.015),
                        _HorizontalMovieList(
                            size: size,
                            category: 'only_on_chillflix',
                            itemWidthFactor: 0.50,
                            heightFactor: 0.32),

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
    required this.category,
    required this.itemWidthFactor,
    this.heightFactor = 0.20,
  });

  final Size size;
  final String category;
  final double itemWidthFactor;
  final double heightFactor;

  @override
  Widget build(BuildContext context) {
    // Widget oluşturulduğunda filmleri yükle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final moviesCubit = context.read<MoviesCubit>();

      switch (category) {
        case 'most_wanted':
          moviesCubit.getMostWantedMovies();
          break;
        case 'only_on_chillflix':
          moviesCubit.getOnlyOnChillflixMovies();
          break;
      }
    });

    return BlocBuilder<MoviesCubit, MoviesState>(
      buildWhen: (previous, current) {
        // Sadece bu kategori için state değişikliklerini dinle
        if (current is MoviesLoaded && current.category == category) {
          return true;
        }
        if (current is MoviesLoading && current.category == category) {
          return true;
        }
        if (current is MoviesError) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is MoviesLoading && state.category == category) {
          return SizedBox(
            height: size.height * heightFactor,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        if (state is MoviesLoaded &&
            state.category == category &&
            state.movies.isNotEmpty) {
          return SizedBox(
            height: size.height * heightFactor,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.movies.length,
              separatorBuilder: (_, __) => SizedBox(width: size.width * 0.03),
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return FilmCard(
                  movie: movie,
                  width: size.width * itemWidthFactor,
                  height: size.height * heightFactor,
                  onTap: () => debugPrint("Film ${movie.title} tıklandı"),
                  onListTap: () {
                    context.read<MoviesCubit>().toggleUserList(
                          movie.id,
                          movie.title,
                          movie.imageUrl,
                        );
                  },
                );
              },
            ),
          );
        }

        // Hata durumu veya boş liste
        return SizedBox(
          height: size.height * heightFactor,
          child: const Center(
            child: Text(
              'Film bulunamadı',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
