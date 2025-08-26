import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../product/services/movie_service.dart';
import '../../product/models/movie_model.dart';
import '../../product/models/user_list_model.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MovieService _movieService = MovieService();

  MoviesCubit() : super(MoviesInitial());

  // Most Wanted kategorisindeki filmleri getir
  Future<void> getMostWantedMovies() async {
    emit(MoviesLoading(category: 'most_wanted'));
    try {
      final movies = await _movieService.getMoviesByCategory('most_wanted');
      emit(MoviesLoaded(movies: movies, category: 'most_wanted'));
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }

  // Only on ChillFlix kategorisindeki filmleri getir
  Future<void> getOnlyOnChillflixMovies() async {
    emit(MoviesLoading(category: 'only_on_chillflix'));
    try {
      final movies =
          await _movieService.getMoviesByCategory('only_on_chillflix');
      emit(MoviesLoaded(movies: movies, category: 'only_on_chillflix'));
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }

  // Coming Soon kategorisindeki filmleri getir
  Future<void> getComingSoonMovies() async {
    emit(MoviesLoading(category: 'coming_soon'));
    try {
      final movies = await _movieService.getMoviesByCategory('coming_soon');
      emit(MoviesLoaded(movies: movies, category: 'coming_soon'));
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }

  // Everyone Watch These kategorisindeki filmleri getir
  Future<void> getEveryoneWatchTheseMovies() async {
    emit(MoviesLoading(category: 'everyone_watch_these'));
    try {
      final movies =
          await _movieService.getMoviesByCategory('everyone_watch_these');
      emit(MoviesLoaded(movies: movies, category: 'everyone_watch_these'));
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }

  // Top 10 filmleri getir
  Future<void> getTop10Movies() async {
    emit(Top10Loading(type: 'movies'));
    try {
      final movies = await _movieService.getTop10Movies();
      emit(Top10Loaded(movies: movies, type: 'movies'));
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }

  // Top 10 dizileri getir
  Future<void> getTop10Series() async {
    emit(Top10Loading(type: 'series'));
    try {
      final movies = await _movieService.getTop10Series();
      emit(Top10Loaded(movies: movies, type: 'series'));
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }

  // Kullanıcının listesine film ekle/çıkar
  Future<void> toggleUserList(
      String movieId, String movieTitle, String movieImageUrl) async {
    try {
      final success =
          await _movieService.addToUserList(movieId, movieTitle, movieImageUrl);
      if (success) {
        // Film listesini güncelle
        final currentState = state;
        if (currentState is MoviesLoaded) {
          emit(MoviesLoaded(movies: currentState.movies));
        }
      }
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }

  // Kullanıcının listesini getir
  Future<void> getUserList() async {
    emit(UserListLoading());
    try {
      final userList = await _movieService.getUserList();
      emit(UserListLoaded(userList: userList));
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }

  // Film listem butonuna basılıp basılmadığını kontrol et
  Future<bool> isInUserList(String movieId) async {
    try {
      return await _movieService.isInUserList(movieId);
    } catch (e) {
      return false;
    }
  }

  // Kullanıcının listesinden film kaldır
  Future<void> removeFromUserList(String listId) async {
    try {
      final success = await _movieService.removeFromUserList(listId);
      if (success) {
        // Listeyi güncelle
        getUserList();
      }
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }
}
