part of 'top_rated_movie_bloc.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object?> get props => [];
}

class TopRatedMovieInitial extends TopRatedMovieState {}

class TopRatedMovieLoadingState extends TopRatedMovieState {}

class TopRatedMovieLoadedState extends TopRatedMovieState {
  final List<Movie>? movieList;

  TopRatedMovieLoadedState({
    required this.movieList,
  });

  @override
  List<Object?> get props => [movieList];
}

class TopRatedMovieFailureState extends TopRatedMovieState {
  final String? errorMessage;

  TopRatedMovieFailureState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
