import 'package:bloc/bloc.dart';
import 'package:movie/domain/entities/movie/movie.dart';
import 'package:movie/domain/use_cases/movie/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMovieBloc({
    required this.getTopRatedMovies,
  }) : super(TopRatedMovieInitial()) {
    on<LoadTopRatedMovieEvent>(_loadTopRatedMovie);
  }

  void _loadTopRatedMovie(
      LoadTopRatedMovieEvent event, Emitter<TopRatedMovieState> emit) async {
    emit(TopRatedMovieLoadingState());

    var result = await getTopRatedMovies.execute();

    result.fold(
      (failure) {
        emit(TopRatedMovieFailureState(errorMessage: failure.message));
      },
      (movieList) {
        emit(TopRatedMovieLoadedState(movieList: movieList));
      },
    );
  }
}
