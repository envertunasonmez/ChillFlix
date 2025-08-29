// movies_state.dart
part of 'movies_cubit.dart';

class MoviesState extends Equatable {
  final List<Movie> mostWantedMovies;
  final bool mostWantedLoading;
  final List<Movie> onlyOnChillflixMovies;
  final bool onlyOnChillflixLoading;
  final List<Movie> comingSoonMovies;
  final bool comingSoonLoading;
  final List<Movie> everyoneWatchTheseMovies;
  final bool everyoneWatchTheseLoading;
  final List<Movie> top10Movies;
  final bool top10MoviesLoading;
  final List<Movie> top10Series;
  final bool top10SeriesLoading;
  final List<UserList> userList;
  final bool userListLoading;
  final String? errorMessage;

  const MoviesState({
    this.mostWantedMovies = const [],
    this.mostWantedLoading = false,
    this.onlyOnChillflixMovies = const [],
    this.onlyOnChillflixLoading = false,
    this.comingSoonMovies = const [],
    this.comingSoonLoading = false,
    this.everyoneWatchTheseMovies = const [],
    this.everyoneWatchTheseLoading = false,
    this.top10Movies = const [],
    this.top10MoviesLoading = false,
    this.top10Series = const [],
    this.top10SeriesLoading = false,
    this.userList = const [],
    this.userListLoading = false,
    this.errorMessage,
  });

  MoviesState copyWith({
    List<Movie>? mostWantedMovies,
    bool? mostWantedLoading,
    List<Movie>? onlyOnChillflixMovies,
    bool? onlyOnChillflixLoading,
    List<Movie>? comingSoonMovies,
    bool? comingSoonLoading,
    List<Movie>? everyoneWatchTheseMovies,
    bool? everyoneWatchTheseLoading,
    List<Movie>? top10Movies,
    bool? top10MoviesLoading,
    List<Movie>? top10Series,
    bool? top10SeriesLoading,
    List<UserList>? userList,
    bool? userListLoading,
    String? errorMessage,
  }) {
    return MoviesState(
      mostWantedMovies: mostWantedMovies ?? this.mostWantedMovies,
      mostWantedLoading: mostWantedLoading ?? this.mostWantedLoading,
      onlyOnChillflixMovies: onlyOnChillflixMovies ?? this.onlyOnChillflixMovies,
      onlyOnChillflixLoading: onlyOnChillflixLoading ?? this.onlyOnChillflixLoading,
      comingSoonMovies: comingSoonMovies ?? this.comingSoonMovies,
      comingSoonLoading: comingSoonLoading ?? this.comingSoonLoading,
      everyoneWatchTheseMovies: everyoneWatchTheseMovies ?? this.everyoneWatchTheseMovies,
      everyoneWatchTheseLoading: everyoneWatchTheseLoading ?? this.everyoneWatchTheseLoading,
      top10Movies: top10Movies ?? this.top10Movies,
      top10MoviesLoading: top10MoviesLoading ?? this.top10MoviesLoading,
      top10Series: top10Series ?? this.top10Series,
      top10SeriesLoading: top10SeriesLoading ?? this.top10SeriesLoading,
      userList: userList ?? this.userList,
      userListLoading: userListLoading ?? this.userListLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        mostWantedMovies,
        mostWantedLoading,
        onlyOnChillflixMovies,
        onlyOnChillflixLoading,
        comingSoonMovies,
        comingSoonLoading,
        everyoneWatchTheseMovies,
        everyoneWatchTheseLoading,
        top10Movies,
        top10MoviesLoading,
        top10Series,
        top10SeriesLoading,
        userList,
        userListLoading,
        errorMessage,
      ];
}

class MoviesInitial extends MoviesState {
  const MoviesInitial();
}
