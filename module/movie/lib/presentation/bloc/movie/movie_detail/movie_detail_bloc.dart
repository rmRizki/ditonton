import 'package:bloc/bloc.dart';
import 'package:movie/domain/entities/movie/movie.dart';
import 'package:movie/domain/entities/movie/movie_detail.dart';
import 'package:movie/domain/use_cases/movie/get_movie_detail.dart';
import 'package:movie/domain/use_cases/movie/get_movie_recommendations.dart';
import 'package:movie/domain/use_cases/movie/get_watchlist_status_movie.dart';
import 'package:movie/domain/use_cases/movie/remove_watchlist_movie.dart';
import 'package:movie/domain/use_cases/movie/save_watchlist_movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatusMovie getWatchListStatus;
  final SaveWatchlistMovie saveWatchlist;
  final RemoveWatchlistMovie removeWatchlist;

  MovieDetail? _movieDetail;
  List<Movie> _movieRecommendations = [];
  bool? _isAddedToWatchlist;
  String? _watchlistMessage;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailInitial()) {
    on<LoadMovieDetailEvent>(_loadMovieDetail);
    on<AddWatchlistEvent>(_addWatchlist);
    on<RemoveWatchlistEvent>(_removeWatchlist);
  }

  void _loadMovieDetail(
    LoadMovieDetailEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoadingState());

    final detailResult = await getMovieDetail.execute(event.id);
    final recommendationResult =
        await getMovieRecommendations.execute(event.id);
    _isAddedToWatchlist = await loadWatchlistStatus(event.id);

    detailResult.fold(
      (failure) => emit(MovieDetailFailureState(errorMessage: failure.message)),
      (movieDetail) {
        _movieDetail = movieDetail;
        emit(
          MovieDetailLoadedState(
            movieDetail: _movieDetail,
            isAddedToWatchlist: _isAddedToWatchlist,
          ),
        );
        recommendationResult.fold(
          (failure) => _movieRecommendations = [],
          (movieRecommendations) =>
              _movieRecommendations = movieRecommendations,
        );
        emit(
          MovieDetailLoadedState(
            movieDetail: _movieDetail,
            recommendationList: _movieRecommendations,
            isAddedToWatchlist: _isAddedToWatchlist,
          ),
        );
      },
    );
  }

  Future<void> _addWatchlist(
    AddWatchlistEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.movieDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    _isAddedToWatchlist = await loadWatchlistStatus(event.movieDetail.id);

    emit(
      MovieDetailLoadedState(
        movieDetail: _movieDetail,
        recommendationList: _movieRecommendations,
        isAddedToWatchlist: _isAddedToWatchlist,
        watchlistMessage: _watchlistMessage,
      ),
    );
  }

  Future<void> _removeWatchlist(
    RemoveWatchlistEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.movieDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    _isAddedToWatchlist = await loadWatchlistStatus(event.movieDetail.id);

    emit(
      MovieDetailLoadedState(
        movieDetail: _movieDetail,
        recommendationList: _movieRecommendations,
        isAddedToWatchlist: _isAddedToWatchlist,
        watchlistMessage: _watchlistMessage,
      ),
    );
  }

  Future<bool> loadWatchlistStatus(int id) async {
    return await getWatchListStatus.execute(id);
  }
}
