import 'package:chillflix_app/cubit/auth/auth_cubit.dart';
import 'package:chillflix_app/cubit/locale/locale_cubit.dart';
import 'package:chillflix_app/cubit/movies/movies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:chillflix_app/generated/l10n.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    // Load user list on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MoviesCubit>().getUserList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blackColor,
      body: RefreshIndicator(
        color: ColorConstants.redColor,
        backgroundColor: ColorConstants.blackColor,
        onRefresh: () async {
          // Refresh user list
          await context.read<MoviesCubit>().getUserList();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                title: "Drive To Survive",
                genre: "Action, Drama",
                date: "20 Aug",
              ),
              const SizedBox(height: 32),
              const DownloadedRow(),
              const SizedBox(height: 32),
              Text(
                S.of(context).likedSeriesAndFilms,
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
      title: S.of(context).myChillflix,
      actions: [
        AppBarIconButton(icon: Icons.cast, onPressed: () {}),
        AppBarIconButton(icon: Icons.search, onPressed: () {}),
        AppBarIconButton(
            icon: Icons.menu, onPressed: () => _openBottomSheet(context)),
      ],
    );
  }
}

class _BottomSheetTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _BottomSheetTile({
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: ColorConstants.whiteColor),
      title: Text(
        title,
        style: AppTextStyles.bodyStyle(color: ColorConstants.whiteColor),
      ),
      onTap: onTap ?? () => Navigator.pop(context),
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
        children: [
          _BottomSheetTile(
            icon: Icons.settings,
            title: S.of(context).settings,
          ),
          _BottomSheetTile(
            icon: Icons.person,
            title: S.of(context).myProfile,
          ),
          _BottomSheetTile(
            icon: Icons.language,
            title: S.of(context).changeLanguage,
            onTap: () => _showLanguageSelector(context),
          ),
          _BottomSheetTile(
            icon: Icons.logout,
            title: S.of(context).logOut,
            onTap: () {
              context.read<AuthCubit>().signOut(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: EdgeInsets.zero,
          title: Container(
            decoration: BoxDecoration(
              color: ColorConstants.redColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                "Dil Seçimi",
                style: AppTextStyles.bodyStyle(
                  color: ColorConstants.blackColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    context.read<LocaleCubit>().setLocale(const Locale('tr'));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    color: Colors.transparent,
                    child: Text(
                      "Türkçe",
                      style: AppTextStyles.bodyStyle(
                        color: ColorConstants.redColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  onTap: () {
                    context.read<LocaleCubit>().setLocale(const Locale('en'));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    color: Colors.transparent,
                    child: Text(
                      "English",
                      style: AppTextStyles.bodyStyle(
                        color: ColorConstants.redColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
