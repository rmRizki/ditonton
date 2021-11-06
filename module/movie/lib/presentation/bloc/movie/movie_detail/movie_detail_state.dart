part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailLoadedState extends MovieDetailState {
  final MovieDetail? movieDetail;
  final List<Movie>? recommendationList;
  final bool? isAddedToWatchlist;
  final String? watchlistMessage;

  MovieDetailLoadedState({
    required this.movieDetail,
    this.recommendationList,
    this.isAddedToWatchlist,
    this.watchlistMessage,
  });

  @override
  List<Object?> get props => [
        movieDetail,
        recommendationList,
        isAddedToWatchlist,
        watchlistMessage,
      ];
}

class MovieDetailFailureState extends MovieDetailState {
  final String? errorMessage;

  MovieDetailFailureState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
