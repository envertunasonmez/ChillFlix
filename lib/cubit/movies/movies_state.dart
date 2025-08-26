part of 'movies_cubit.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object?> get props => [];
}

class MoviesInitial extends MoviesState {}

// Kategori bazlı durumlar
class MoviesLoading extends MoviesState {
  final String category;

  const MoviesLoading({this.category = ''});

  @override
  List<Object?> get props => [category];
}

class MoviesLoaded extends MoviesState {
  final List<Movie> movies;
  final String category;

  const MoviesLoaded({required this.movies, this.category = ''});

  @override
  List<Object?> get props => [movies, category];
}

class Top10Loading extends MoviesState {
  final String type; // 'movies' veya 'series'

  const Top10Loading({required this.type});

  @override
  List<Object?> get props => [type];
}

class Top10Loaded extends MoviesState {
  final List<Movie> movies;
  final String type;

  const Top10Loaded({required this.movies, required this.type});

  @override
  List<Object?> get props => [movies, type];
}

class UserListLoading extends MoviesState {}

class UserListLoaded extends MoviesState {
  final List<UserList> userList;

  const UserListLoaded({required this.userList});

  @override
  List<Object?> get props => [userList];
}

class MoviesError extends MoviesState {
  final String message;

  const MoviesError({required this.message});

  @override
  List<Object?> get props => [message];
}
