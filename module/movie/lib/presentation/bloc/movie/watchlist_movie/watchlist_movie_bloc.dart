import 'package:bloc/bloc.dart';
import 'package:movie/domain/entities/movie/movie.dart';
import 'package:movie/domain/use_cases/movie/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc({
    required this.getWatchlistMovies,
  }) : super(WatchlistMovieInitial()) {
    on<LoadWatchlistMovieEvent>(_loadWatchlistMovie);
  }

  void _loadWatchlistMovie(
      LoadWatchlistMovieEvent event, Emitter<WatchlistMovieState> emit) async {
    emit(WatchlistMovieLoadingState());

    var result = await getWatchlistMovies.execute();

    result.fold(
      (failure) {
        emit(WatchlistMovieFailureState(errorMessage: failure.message));
      },
      (movieList) {
        emit(WatchlistMovieLoadedState(movieList: movieList));
      },
    );
  }
}
