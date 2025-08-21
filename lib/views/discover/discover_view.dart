import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillflix_app/cubit/discover/discover_view_cubit.dart';
import 'package:chillflix_app/cubit/discover/discover_view_state.dart';
import 'package:chillflix_app/views/discover/widgets/category_list.dart';
import 'package:chillflix_app/views/discover/widgets/film_list.dart';
import 'package:chillflix_app/product/widgets/custom_app_bar.dart';
import 'package:chillflix_app/views/home/widgets/appbar_icon_buttons.dart';
import 'package:chillflix_app/product/constants/string_constants.dart';

class DiscoverView extends StatelessWidget {
  DiscoverView({super.key});

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
              CustomAppBar(
                title: StringConstants.newAndPopular,
                actions: [
                  AppBarIconButton(icon: Icons.cast, onPressed: () {}),
                  AppBarIconButton(icon: Icons.download, onPressed: () {}),
                  AppBarIconButton(icon: Icons.search, onPressed: () {}),
                ],
              ),
              CategoryList(
                categories: state.categories,
                selectedIndex: state.selectedIndex,
                onTap: (index) {
                  context.read<DiscoverCubit>().selectCategory(index);
                  _scrollToCategory(index);
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FilmList(
                  scrollController: _scrollController,
                  categoryKeys: _categoryKeys,
                  categories: state.categories,
                  onCategoryVisible: (index) {
                    final cubit = context.read<DiscoverCubit>();
                    if (cubit.state.selectedIndex != index) {
                      cubit.selectCategory(index);
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
