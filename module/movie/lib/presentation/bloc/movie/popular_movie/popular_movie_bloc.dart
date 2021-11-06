import 'package:bloc/bloc.dart';
import 'package:movie/domain/entities/movie/movie.dart';
import 'package:movie/domain/use_cases/movie/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;

  PopularMovieBloc({
    required this.getPopularMovies,
  }) : super(PopularMovieInitial()) {
    on<LoadPopularMovieEvent>(_loadPopularMovie);
  }

  void _loadPopularMovie(
      LoadPopularMovieEvent event, Emitter<PopularMovieState> emit) async {
    emit(PopularMovieLoadingState());

    var result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(PopularMovieFailureState(errorMessage: failure.message));
      },
      (movieList) {
        emit(PopularMovieLoadedState(movieList: movieList));
      },
    );
  }
}
