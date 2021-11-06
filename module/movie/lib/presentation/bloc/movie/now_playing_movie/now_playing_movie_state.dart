part of 'now_playing_movie_bloc.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object?> get props => [];
}

class NowPlayingMovieInitial extends NowPlayingMovieState {}

class NowPlayingMovieLoadingState extends NowPlayingMovieState {}

class NowPlayingMovieLoadedState extends NowPlayingMovieState {
  final List<Movie>? movieList;

  NowPlayingMovieLoadedState({
    required this.movieList,
  });

  @override
  List<Object?> get props => [movieList];
}

class NowPlayingMovieFailureState extends NowPlayingMovieState {
  final String? errorMessage;

  NowPlayingMovieFailureState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
