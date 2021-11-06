part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object?> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchLoadingState extends MovieSearchState {}

class MovieSearchLoadedState extends MovieSearchState {
  final List<Movie>? movieList;

  MovieSearchLoadedState({
    required this.movieList,
  });

  @override
  List<Object?> get props => [movieList];
}

class MovieSearchFailureState extends MovieSearchState {
  final String? errorMessage;

  MovieSearchFailureState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
