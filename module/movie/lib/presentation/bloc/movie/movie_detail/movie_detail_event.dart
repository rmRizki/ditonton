part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class LoadMovieDetailEvent extends MovieDetailEvent {
  final int id;

  LoadMovieDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class AddWatchlistEvent extends MovieDetailEvent {
  final MovieDetail movieDetail;

  AddWatchlistEvent({required this.movieDetail});

  @override
  List<Object> get props => [movieDetail];
}

class RemoveWatchlistEvent extends MovieDetailEvent {
  final MovieDetail movieDetail;

  RemoveWatchlistEvent({required this.movieDetail});

  @override
  List<Object> get props => [movieDetail];
}
