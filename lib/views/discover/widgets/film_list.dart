import 'package:flutter/material.dart';
import 'film_card.dart';

class FilmList extends StatelessWidget {
  final ScrollController scrollController;
  final List<GlobalKey> categoryKeys;
  final List<Map<String, String>> categories;
  final Function(int) onCategoryVisible;

  const FilmList({
    super.key,
    required this.scrollController,
    required this.categoryKeys,
    required this.categories,
    required this.onCategoryVisible,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollUpdateNotification) {
          for (int i = 0; i < categoryKeys.length; i++) {
            final keyContext = categoryKeys[i].currentContext;
            if (keyContext != null) {
              final box = keyContext.findRenderObject() as RenderBox;
              final position = box.localToGlobal(Offset.zero).dy;
              if (position > 0 && position < 200) {
                onCategoryVisible(i);
                break;
              }
            }
          }
        }
        return false;
      },
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: List.generate(
            categories.length,
            (index) => FilmCardSection(
              key: categoryKeys[index],
              category: categories[index],
              isComingSoon: index == 0,
            ),
          ),
        ),
      ),
    );
  }
}
