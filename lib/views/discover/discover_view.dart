import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillflix_app/cubit/discover/discover_view_cubit.dart';
import 'package:chillflix_app/cubit/discover/discover_view_state.dart';
import 'package:chillflix_app/product/constants/assets_constants.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/constants/string_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:chillflix_app/product/widgets/custom_app_bar.dart';
import 'package:chillflix_app/views/home/widgets/appbar_icon_buttons.dart';

class DiscoverView extends StatelessWidget {
  DiscoverView({super.key});

  static const double categoryButtonHeight = 48;
  static const double filmCardImageHeight = 200;
  static const double filmCardBorderRadius = 16;
  static const double filmCardPadding = 12;

  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _categoryKeys = List.generate(4, (_) => GlobalKey());

  void _scrollToCategory(int index) {
    final context = _categoryKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DiscoverCubit(),
      child: BlocBuilder<DiscoverCubit, DiscoverState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildAppBar(),
              _buildCategoryList(context, state),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: List.generate(
                      state.categories.length,
                      (index) =>
                          _buildFilmList(context, index, state.selectedIndex),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      title: StringConstants.newAndPopular,
      actions: [
        AppBarIconButton(
          icon: Icons.cast,
          onPressed: () {},
        ),
        AppBarIconButton(
          icon: Icons.download,
          onPressed: () {},
        ),
        AppBarIconButton(
          icon: Icons.search,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildCategoryList(BuildContext context, DiscoverState state) {
    return SizedBox(
      height: categoryButtonHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        itemCount: state.categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = state.categories[index];
          final isSelected = state.selectedIndex == index;
          return _buildCategoryButton(context, index, category, isSelected);
        },
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, int index,
      Map<String, String> category, bool isSelected) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? ColorConstants.greyColor : Colors.transparent,
        foregroundColor: ColorConstants.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: ColorConstants.greyColor),
        ),
      ),
      onPressed: () {
        context.read<DiscoverCubit>().selectCategory(index);
        _scrollToCategory(index);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("${category['emoji']} ", style: const TextStyle(fontSize: 16)),
          Text(category['title']!, style: AppTextStyles.buttonStyle()),
        ],
      ),
    );
  }

  Widget _buildFilmList(
      BuildContext context, int categoryIndex, int selectedIndex) {
    final category =
        context.read<DiscoverCubit>().state.categories[categoryIndex];

    return Container(
      key: _categoryKeys[categoryIndex],
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kategori başlığı
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "${category['emoji']} ${category['title']}",
              style: AppTextStyles.bodyStyle(
                fontSize: 20,
                color: ColorConstants.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Film kartları
          ...List.generate(
            5,
            (index) => _buildFilmCard(index, categoryIndex),
          ),
        ],
      ),
    );
  }

  Widget _buildFilmCard(int index, int categoryIndex) {
    bool isComingSoon = categoryIndex == 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(filmCardBorderRadius),
        border: Border.all(
          color: ColorConstants.greyColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilmImage(),
          _buildFilmInfo(index, isComingSoon: isComingSoon),
        ],
      ),
    );
  }

  Widget _buildFilmImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(filmCardBorderRadius),
        topRight: Radius.circular(filmCardBorderRadius),
      ),
      child: Image.asset(
        AssetsConstants.banner,
        height: filmCardImageHeight,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildFilmInfo(int index, {bool isComingSoon = true}) {
    return Padding(
      padding: const EdgeInsets.all(filmCardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isComingSoon
                ? "Çok Yakında: Harika Bir Film ${index + 1}"
                : "Film ${index + 1}",
            style: AppTextStyles.bodyStyle(
              fontSize: 18,
              color: ColorConstants.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Bu filmde büyük bir macera seni bekliyor. "
            "Aksiyon, dram ve heyecanın birleştiği unutulmaz sahneler!",
            style: AppTextStyles.bodyStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          isComingSoon ? _buildReminderButton() : _buildPlayAndListButton(),
        ],
      ),
    );
  }

  Widget _buildReminderButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.notifications_none,
          color: ColorConstants.blackColor, size: 24),
      label: Text(
        StringConstants.remindMe,
        style: AppTextStyles.buttonStyle(
          color: ColorConstants.blackColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.whiteColor,
        foregroundColor: ColorConstants.blackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildPlayAndListButton() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon:
                const Icon(Icons.play_arrow, color: ColorConstants.blackColor),
            label: Text(
              "Oynat",
              style: AppTextStyles.buttonStyle(
                color: ColorConstants.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.whiteColor,
              foregroundColor: ColorConstants.blackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, color: ColorConstants.blackColor),
          label: Text(
            "Listem",
            style: AppTextStyles.buttonStyle(
              color: ColorConstants.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.whiteColor,
            foregroundColor: ColorConstants.blackColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}
