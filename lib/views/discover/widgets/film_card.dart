import 'package:chillflix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/constants/assets_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:chillflix_app/cubit/movies/movies_cubit.dart';
import 'package:chillflix_app/product/models/movie_model.dart';

class FilmCardSection extends StatelessWidget {
  final Map<String, String> category;
  final bool isComingSoon;
  final int categoryIndex; // Hangi kategori olduğunu belirtmek için

  const FilmCardSection({
    super.key,
    required this.category,
    this.isComingSoon = true,
    required this.categoryIndex,
  });

  Widget _buildMovieImage(Movie movie) {
    // URL'deki tırnak işaretlerini temizle
    String cleanUrl = movie.imageUrl.replaceAll('"', '').trim();

    if (cleanUrl.isEmpty || !Uri.tryParse(cleanUrl)!.hasScheme == true) {
      return Image.asset(
        AssetsConstants.banner,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    return Image.network(
      cleanUrl,
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print("Image loading error for URL: $cleanUrl - Error: $error");
        return Image.asset(
          AssetsConstants.banner,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey[800],
          child: const Center(
            child: CircularProgressIndicator(
              color: ColorConstants.whiteColor,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              "${category['emoji']} ${category['title']}",
              style: AppTextStyles.bodyStyle(
                fontSize: 20,
                color: ColorConstants.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<MoviesCubit, MoviesState>(
            builder: (context, state) {
              // Kategori bazında loading kontrolü
              bool isLoading = false;
              List<Movie> movies = [];
              String? error = state.errorMessage;

              switch (categoryIndex) {
                case 0: // Çok Yakında
                  isLoading = state.comingSoonLoading;
                  movies = state.comingSoonMovies;
                  break;
                case 1: // Herkes Bunları İzliyor
                  isLoading = state.everyoneWatchTheseLoading;
                  movies = state.everyoneWatchTheseMovies;
                  break;
                case 2: // Top 10 Filmler
                  isLoading = state.top10MoviesLoading;
                  movies = state.top10Movies;
                  break;
                case 3: // Top 10 Diziler
                  isLoading = state.top10SeriesLoading;
                  movies = state.top10Series;
                  break;
              }

              // Loading durumu
              if (isLoading) {
                return _buildLoadingWidget();
              }

              // Error durumu
              if (error != null) {
                return _buildErrorWidget(error);
              }

              // Empty durumu
              if (movies.isEmpty) {
                return _buildEmptyWidget();
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return FilmCard(
                    movie: movies[index],
                    isComingSoon: isComingSoon,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: ColorConstants.whiteColor,
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          'Hata: $message',
          style: AppTextStyles.bodyStyle(
            color: ColorConstants.whiteColor,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          'Bu kategoride film bulunamadı',
          style: AppTextStyles.bodyStyle(
            color: ColorConstants.whiteColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class FilmCard extends StatelessWidget {
  final Movie movie;
  final bool isComingSoon;

  const FilmCard({
    super.key,
    required this.movie,
    this.isComingSoon = true,
  });

  Widget _buildMovieImage(Movie movie) {
    // URL'deki tırnak işaretlerini temizle
    String cleanUrl = movie.imageUrl.replaceAll('"', '').trim();

    if (cleanUrl.isEmpty || !Uri.tryParse(cleanUrl)!.hasScheme == true) {
      return Image.asset(
        AssetsConstants.banner,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    return Image.network(
      cleanUrl,
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print("Image loading error for URL: $cleanUrl - Error: $error");
        return Image.asset(
          AssetsConstants.banner,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey[800],
          child: const Center(
            child: CircularProgressIndicator(
              color: ColorConstants.whiteColor,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorConstants.greyColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: _buildMovieImage(movie),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: AppTextStyles.bodyStyle(
                    fontSize: 18,
                    color: ColorConstants.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  movie.description,
                  style: AppTextStyles.bodyStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO: Hatırlatma işlevi ekle
        },
        icon: const Icon(
          Icons.notifications_none,
          color: ColorConstants.blackColor,
          size: 28,
        ),
        label: Text(
          S.of(context).remindMe,
          style: AppTextStyles.buttonStyle(
            color: ColorConstants.blackColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.whiteColor,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayAndListButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Oynatma işlevi ekle
            },
            icon: const Icon(
              Icons.play_arrow,
              color: ColorConstants.blackColor,
              size: 28,
            ),
            label: Text(
              S.of(context).play,
              style: AppTextStyles.buttonStyle(
                color: ColorConstants.blackColor,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.whiteColor,
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: BlocBuilder<MoviesCubit, MoviesState>(
            builder: (context, state) {
              return FutureBuilder<bool>(
                future: context.read<MoviesCubit>().isInUserList(movie.id),
                builder: (context, snapshot) {
                  final isInList = snapshot.data ?? false;
                  return ElevatedButton.icon(
                    onPressed: () {
                      context.read<MoviesCubit>().toggleUserList(
                            movie.id,
                            movie.title,
                            movie.imageUrl,
                          );
                    },
                    icon: Icon(
                      isInList ? Icons.check : Icons.add,
                      color: ColorConstants.whiteColor,
                      size: 28,
                    ),
                    label: Text(
                      S.of(context).myList,
                      style: AppTextStyles.buttonStyle(
                        color: ColorConstants.whiteColor,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.greyColor,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
