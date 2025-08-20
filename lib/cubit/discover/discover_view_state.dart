import 'package:equatable/equatable.dart';

class DiscoverState extends Equatable {
  final int selectedIndex;
  final List<Map<String, String>> categories;

  const DiscoverState({
    required this.selectedIndex,
    required this.categories,
  });

  DiscoverState copyWith({
    int? selectedIndex,
    List<Map<String, String>>? categories,
  }) {
    return DiscoverState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object> get props => [selectedIndex, categories];
}
