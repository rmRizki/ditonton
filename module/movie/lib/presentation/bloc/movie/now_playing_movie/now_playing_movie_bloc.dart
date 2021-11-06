import 'package:bloc/bloc.dart';
import 'package:movie/domain/entities/movie/movie.dart';
import 'package:movie/domain/use_cases/movie/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMovieBloc({
    required this.getNowPlayingMovies,
  }) : super(NowPlayingMovieInitial()) {
    on<LoadNowPlayingMovieEvent>(_loadNowPlayingMovie);
  }

  void _loadNowPlayingMovie(LoadNowPlayingMovieEvent event,
      Emitter<NowPlayingMovieState> emit) async {
    emit(NowPlayingMovieLoadingState());

    var result = await getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        emit(NowPlayingMovieFailureState(errorMessage: failure.message));
      },
      (movieList) {
        emit(NowPlayingMovieLoadedState(movieList: movieList));
      },
    );
  }
}
