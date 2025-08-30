import 'package:chillflix_app/product/constants/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillflix_app/generated/l10n.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:chillflix_app/views/home/widgets/appbar_icon_buttons.dart';
import 'package:chillflix_app/views/home/widgets/category_buttons.dart';
import 'package:chillflix_app/views/home/widgets/banner_action_buttons.dart';
import 'package:chillflix_app/product/widgets/custom_app_bar.dart';
import 'package:chillflix_app/product/widgets/film_card.dart';
import 'package:chillflix_app/cubit/movies/movies_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        CustomAppBar(
          title: 'Tuna için',
          actions: [
            AppBarIconButton(icon: Icons.cast, onPressed: () {}),
            AppBarIconButton(icon: Icons.download, onPressed: () {}),
            AppBarIconButton(icon: Icons.search, onPressed: () {}),
          ],
        ),
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 12),
                        _CategoryRow(),
                        SizedBox(height: 12),
                        _BannerWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// 🔹 Film Listeleri
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionTitle(title: 'Most Wanted', size: size),
                        SizedBox(height: size.height * 0.015),
                        _MovieHorizontalList(
                            categoryKey: 'most_wanted',
                            size: size,
                            heightFactor: 0.25,
                            itemWidthFactor: 0.3),
                        SizedBox(height: size.height * 0.02),
                        _SectionTitle(title: 'Only on ChillFlix', size: size),
                        SizedBox(height: size.height * 0.015),
                        _MovieHorizontalList(
                            categoryKey: 'only_on_chillflix',
                            size: size,
                            heightFactor: 0.32,
                            itemWidthFactor: 0.5),
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

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              onPressed: () {}),
        ),
      ],
    );
  }
}

class _BannerWidget extends StatelessWidget {
  const _BannerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.58,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size.width * 0.04),
        child: Stack(
          children: [
            Positioned.fill(
                child: Image.asset(AssetsConstants.banner, fit: BoxFit.cover)),
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.size, super.key});
  final String title;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.bodyStyle(
          fontSize: size.width * 0.05,
          color: ColorConstants.whiteColor,
          fontWeight: FontWeight.bold),
    );
  }
}

/// 🔹 Yeni null-safe yatay liste
class _MovieHorizontalList extends StatelessWidget {
  const _MovieHorizontalList({
    required this.categoryKey,
    required this.size,
    required this.heightFactor,
    required this.itemWidthFactor,
    super.key,
  });

  final String categoryKey;
  final Size size;
  final double heightFactor;
  final double itemWidthFactor;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MoviesCubit>();

    // Kategoriye göre veriyi çek
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (categoryKey) {
        case 'most_wanted':
          cubit.getMostWantedMovies();
          break;
        case 'only_on_chillflix':
          cubit.getOnlyOnChillflixMovies();
          break;
        case 'coming_soon':
          cubit.getComingSoonMovies();
          break;
      }
    });

    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        List movies = [];

        switch (categoryKey) {
          case 'most_wanted':
            movies = state.mostWantedMovies;
            break;
          case 'only_on_chillflix':
            movies = state.onlyOnChillflixMovies;
            break;
          case 'coming_soon':
            movies = state.comingSoonMovies;
            break;
        }

        bool isLoading = false;
        switch (categoryKey) {
          case 'most_wanted':
            isLoading = state.mostWantedLoading;
            break;
          case 'only_on_chillflix':
            isLoading = state.onlyOnChillflixLoading;
            break;
          case 'coming_soon':
            isLoading = state.comingSoonLoading;
            break;
        }

        if (isLoading) {
          return SizedBox(
            height: size.height * heightFactor,
            child: const Center(
                child: CircularProgressIndicator(color: Colors.white)),
          );
        }

        if (movies.isEmpty) {
          return SizedBox(
            height: size.height * heightFactor,
            child: const Center(
                child: Text('Film bulunamadı',
                    style: TextStyle(color: Colors.white))),
          );
        }

        return SizedBox(
          height: size.height * heightFactor,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (_, __) => SizedBox(width: size.width * 0.03),
            itemBuilder: (context, index) {
              final movie = movies[index];
              return FilmCard(
                movie: movie,
                width: size.width * itemWidthFactor,
                height: size.height * heightFactor,
                onTap: () {},
                onListTap: () {
                  cubit.toggleUserList(movie.id, movie.title, movie.imageUrl);
                },
              );
            },
          ),
        );
      },
    );
  }
}
