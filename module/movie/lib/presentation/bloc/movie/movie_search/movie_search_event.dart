part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();
}

class LoadMovieSearchEvent extends MovieSearchEvent {
  final String query;

  LoadMovieSearchEvent({required this.query});

  @override
  List<Object> get props => [query];
}
