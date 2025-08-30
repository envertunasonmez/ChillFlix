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
  String _cleanImageUrl(String imageUrl) {
    return imageUrl.replaceAll('"', '').trim();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {        
        if (state.userListLoading) {
          return SizedBox(
            height: 190,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: ColorConstants.whiteColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Filmleriniz yükleniyor...',
                    style: AppTextStyles.bodyStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

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
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Bir hata oluştu',
                      style: AppTextStyles.bodyStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.read<MoviesCubit>().getUserList();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.redColor,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: Text(
                        'Tekrar Dene',
                        style: AppTextStyles.buttonStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

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
                    Icon(
                      Icons.movie_outlined,
                      color: Colors.grey,
                      size: 32,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Henüz film eklemedin',
                      style: AppTextStyles.bodyStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Beğendiğin filmleri listene ekle',
                      style: AppTextStyles.bodyStyle(
                        color: Colors.grey[600],
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
                  // Loading state message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${userListItem.movieTitle} kaldırılıyor...'),
                      backgroundColor: ColorConstants.greyColor,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                  
                  // remove film from user list
                  await context.read<MoviesCubit>().removeFromUserList(userListItem.id);
                  
                  // Success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${userListItem.movieTitle} listeden kaldırıldı'),
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
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Film image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: cleanUrl.isNotEmpty && Uri.tryParse(cleanUrl)?.hasScheme == true
                    ? Image.network(
                        cleanUrl,
                        width: 120,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AssetsConstants.banner,
                            width: 120,
                            height: 150,
                            fit: BoxFit.cover,
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 120,
                            height: 150,
                            color: Colors.grey[800],
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
            
            // Remove button
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: ColorConstants.redColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onRemove,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.remove,
                            size: 16,
                            color: ColorConstants.whiteColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Kaldır',
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