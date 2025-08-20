import 'package:bloc/bloc.dart';
import 'package:chillflix_app/product/constants/string_constants.dart';
import 'discover_view_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit()
      : super(
          const DiscoverState(
            selectedIndex: 0,
            categories: [
              {"emoji": "🎬", "title": StringConstants.comingSoon},
              {"emoji": "🔥", "title": StringConstants.watchingEveryoneThese},
              {"emoji": "🎥", "title": StringConstants.topTenFilms},
              {"emoji": "📺", "title": StringConstants.topTenSeries},
            ],
          ),
        );

  void selectCategory(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
