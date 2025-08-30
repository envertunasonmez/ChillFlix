import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../product/services/movie_service.dart';
import '../../product/models/movie_model.dart';
import '../../product/models/user_list_model.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MovieService _movieService = MovieService();

  MoviesCubit() : super(const MoviesInitial());

  Future<void> getMostWantedMovies() async {
    emit(state.copyWith(mostWantedLoading: true));
    try {
      final movies = await _movieService.getMoviesByCategory('most_wanted');
      emit(state.copyWith(mostWantedMovies: movies, mostWantedLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), mostWantedLoading: false));
    }
  }

  Future<void> getOnlyOnChillflixMovies() async {
    emit(state.copyWith(onlyOnChillflixLoading: true));
    try {
      final movies = await _movieService.getMoviesByCategory('only_on_chillflix');
      emit(state.copyWith(onlyOnChillflixMovies: movies, onlyOnChillflixLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), onlyOnChillflixLoading: false));
    }
  }

  Future<void> getComingSoonMovies() async {
    emit(state.copyWith(comingSoonLoading: true));
    try {
      final movies = await _movieService.getMoviesByCategory('coming_soon');
      emit(state.copyWith(comingSoonMovies: movies, comingSoonLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), comingSoonLoading: false));
    }
  }

  Future<void> getEveryoneWatchTheseMovies() async {
    emit(state.copyWith(everyoneWatchTheseLoading: true));
    try {
      final movies = await _movieService.getMoviesByCategory('everyone_watch_these');
      emit(state.copyWith(everyoneWatchTheseMovies: movies, everyoneWatchTheseLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), everyoneWatchTheseLoading: false));
    }
  }

  Future<void> getTop10Movies() async {
    emit(state.copyWith(top10MoviesLoading: true));
    try {
      final movies = await _movieService.getTop10Movies();
      emit(state.copyWith(top10Movies: movies, top10MoviesLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), top10MoviesLoading: false));
    }
  }

  Future<void> getTop10Series() async {
    emit(state.copyWith(top10SeriesLoading: true));
    try {
      final movies = await _movieService.getTop10Series();
      emit(state.copyWith(top10Series: movies, top10SeriesLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), top10SeriesLoading: false));
    }
  }

  /// Add or remove a movie from the user's list
  Future<bool> toggleUserList(String movieId, String movieTitle, String movieImageUrl) async {
    try {
      final result = await _movieService.addToUserList(movieId, movieTitle, movieImageUrl);
      
      // Refresh the user list after toggling
      await getUserList();
      
      return result;
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
      throw e;
    }
  }

  Future<void> getUserList() async {
    emit(state.copyWith(userListLoading: true, errorMessage: null));
    try {
      final userList = await _movieService.getUserList();
      emit(state.copyWith(userList: userList, userListLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), userListLoading: false));
    }
  }

  Future<bool> isInUserList(String movieId) async {
    try {
      final result = await _movieService.isInUserList(movieId);
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<void> removeFromUserList(String listId) async {
    try {
      final success = await _movieService.removeFromUserList(listId);
      if (success) {
        await getUserList();
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}