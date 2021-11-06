import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:movie/domain/entities/movie/movie.dart';
import 'package:movie/domain/use_cases/movie/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({
    required this.searchMovies,
  }) : super(MovieSearchInitial()) {
    on<LoadMovieSearchEvent>(
      _loadMovieSearch,
      transformer: (events, mapper) => restartable<LoadMovieSearchEvent>().call(
        events.debounceTime(Duration(milliseconds: 500)),
        mapper,
      ),
    );
  }

  void _loadMovieSearch(
      LoadMovieSearchEvent event, Emitter<MovieSearchState> emit) async {
    emit(MovieSearchLoadingState());

    var result = await searchMovies.execute(event.query);

    result.fold(
      (failure) {
        emit(MovieSearchFailureState(errorMessage: failure.message));
      },
      (movieList) {
        emit(MovieSearchLoadedState(movieList: movieList));
      },
    );
  }
}
