import 'package:chillflix_app/generated/l10n.dart';
import 'package:chillflix_app/product/models/user_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillflix_app/product/constants/assets_constants.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:chillflix_app/cubit/movies/movies_cubit.dart';

class LikedMoviesList extends StatefulWidget {
  const LikedMoviesList({super.key});

  @override
  State<LikedMoviesList> createState() => _LikedMoviesListState();
}

class _LikedMoviesListState extends State<LikedMoviesList> {
  /// Image URL cleaning
  String _cleanImageUrl(String imageUrl) {
    return imageUrl.replaceAll('"', '').trim();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        /// 🔹 Loading State
        if (state.userListLoading) {
          return SizedBox(
            height: 190,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                      color: ColorConstants.whiteColor),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context).yourMoviesAreLoading,
                    style: AppTextStyles.bodyStyle(
                      color: ColorConstants.greyColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        /// 🔹 Error State
        if (state.errorMessage != null) {
          return SizedBox(
            height: 190,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline,
                        color: ColorConstants.redColor, size: 32),
                    const SizedBox(height: 8),
                    Text(
                      S.of(context).anErrorOccurred,
                      style: AppTextStyles.bodyStyle(
                        color: ColorConstants.redColor,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<MoviesCubit>().getUserList(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.redColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                      child: Text(
                        S.of(context).tryAgain,
                        style: AppTextStyles.buttonStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        /// 🔹 Empty List State
        if (state.userList.isEmpty) {
          return SizedBox(
            height: 190,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.movie_outlined,
                        color: ColorConstants.greyColor, size: 32),
                    const SizedBox(height: 12),
                    Text(
                      S.of(context).youHaveNotAddedAnyMoviesYet,
                      style: AppTextStyles.bodyStyle(
                        color: ColorConstants.greyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      S.of(context).addYourFavoriteMoviesToYourList,
                      style: AppTextStyles.bodyStyle(
                        color: ColorConstants.greyColor,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        /// 🔹 Film List
        return SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.userList.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final userListItem = state.userList[index];
              final cleanUrl = _cleanImageUrl(userListItem.movieImageUrl);

              return _MovieListItem(
                userListItem: userListItem,
                cleanUrl: cleanUrl,
                onRemove: () async {
                  /// Loading SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${userListItem.movieTitle} removing'),
                      backgroundColor: ColorConstants.greyColor,
                      duration: const Duration(seconds: 1),
                    ),
                  );

                  /// Remove from list
                  await context
                      .read<MoviesCubit>()
                      .removeFromUserList(userListItem.id);

                  /// Success SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${userListItem.movieTitle} removed from your list'),
                      backgroundColor: ColorConstants.redColor,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _MovieListItem extends StatelessWidget {
  final UserList userListItem;
  final String cleanUrl;
  final VoidCallback onRemove;

  const _MovieListItem({
    required this.userListItem,
    required this.cleanUrl,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          color: ColorConstants.greyColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.blackColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            /// 🔹 Film Image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: cleanUrl.isNotEmpty &&
                        Uri.tryParse(cleanUrl)?.hasScheme == true
                    ? Image.network(
                        cleanUrl,
                        width: 120,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          AssetsConstants.banner,
                          width: 120,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 120,
                            height: 150,
                            color: ColorConstants.greyColor,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: ColorConstants.whiteColor,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        AssetsConstants.banner,
                        width: 120,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            /// 🔹 Remove button
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: ColorConstants.redColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(12)),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onRemove,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(12)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.remove,
                              size: 16, color: ColorConstants.whiteColor),
                          const SizedBox(width: 4),
                          Text(
                            S.of(context).remove,
                            style: AppTextStyles.buttonStyle(
                              color: ColorConstants.whiteColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
