part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object?> get props => [];
}

class WatchlistMovieInitial extends WatchlistMovieState {}

class WatchlistMovieLoadingState extends WatchlistMovieState {}

class WatchlistMovieLoadedState extends WatchlistMovieState {
  final List<Movie>? movieList;

  WatchlistMovieLoadedState({
    required this.movieList,
  });

  @override
  List<Object?> get props => [movieList];
}

class WatchlistMovieFailureState extends WatchlistMovieState {
  final String? errorMessage;

  WatchlistMovieFailureState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
