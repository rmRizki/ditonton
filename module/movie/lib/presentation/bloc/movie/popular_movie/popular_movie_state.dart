part of 'popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object?> get props => [];
}

class PopularMovieInitial extends PopularMovieState {}

class PopularMovieLoadingState extends PopularMovieState {}

class PopularMovieLoadedState extends PopularMovieState {
  final List<Movie>? movieList;

  PopularMovieLoadedState({
    required this.movieList,
  });

  @override
  List<Object?> get props => [movieList];
}

class PopularMovieFailureState extends PopularMovieState {
  final String? errorMessage;

  PopularMovieFailureState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
