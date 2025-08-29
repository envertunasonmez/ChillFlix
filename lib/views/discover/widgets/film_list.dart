import 'package:flutter/material.dart';
import 'film_card.dart';

// ... (imports)

class FilmList extends StatefulWidget {
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
  State<FilmList> createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollUpdateNotification) {
          for (int i = 0; i < widget.categoryKeys.length; i++) {
            final keyContext = widget.categoryKeys[i].currentContext;
            if (keyContext != null) {
              final box = keyContext.findRenderObject() as RenderBox;
              final position = box.localToGlobal(Offset.zero).dy;
              if (position > 0 && position < 200) {
                widget.onCategoryVisible(i);
                break;
              }
            }
          }
        }
        return false;
      },
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          children: List.generate(
            widget.categories.length,
            (index) => FilmCardSection(
              key: widget.categoryKeys[index],
              category: widget.categories[index],
              isComingSoon: index == 0,
              categoryIndex: index,
            ),
          ),
        ),
      ),
    );
  }
}
