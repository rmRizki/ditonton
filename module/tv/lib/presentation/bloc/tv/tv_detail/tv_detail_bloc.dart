import 'package:bloc/bloc.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/entities/tv/tv_detail.dart';
import 'package:tv/domain/use_cases/tv/get_tv_detail.dart';
import 'package:tv/domain/use_cases/tv/get_tv_recommendations.dart';
import 'package:tv/domain/use_cases/tv/get_watchlist_status_tv.dart';
import 'package:tv/domain/use_cases/tv/remove_watchlist_tv.dart';
import 'package:tv/domain/use_cases/tv/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatusTv getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  TvDetail? _tvDetail;
  List<Tv> _tvRecommendations = [];
  bool? _isAddedToWatchlist;
  String? _watchlistMessage;

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvDetailInitial()) {
    on<LoadTvDetailEvent>(_loadTvDetail);
    on<AddWatchlistEvent>(_addWatchlist);
    on<RemoveWatchlistEvent>(_removeWatchlist);
  }

  void _loadTvDetail(
    LoadTvDetailEvent event,
    Emitter<TvDetailState> emit,
  ) async {
    emit(TvDetailLoadingState());

    final detailResult = await getTvDetail.execute(event.id);
    final recommendationResult = await getTvRecommendations.execute(event.id);
    _isAddedToWatchlist = await loadWatchlistStatus(event.id);

    detailResult.fold(
      (failure) => emit(TvDetailFailureState(errorMessage: failure.message)),
      (tvDetail) {
        _tvDetail = tvDetail;
        emit(
          TvDetailLoadedState(
            tvDetail: _tvDetail,
            isAddedToWatchlist: _isAddedToWatchlist,
          ),
        );
        recommendationResult.fold(
          (failure) => _tvRecommendations = [],
          (tvRecommendations) => _tvRecommendations = tvRecommendations,
        );
        emit(
          TvDetailLoadedState(
            tvDetail: _tvDetail,
            recommendationList: _tvRecommendations,
            isAddedToWatchlist: _isAddedToWatchlist,
          ),
        );
      },
    );
  }

  Future<void> _addWatchlist(
    AddWatchlistEvent event,
    Emitter<TvDetailState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.tvDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    _isAddedToWatchlist = await loadWatchlistStatus(event.tvDetail.id);

    emit(
      TvDetailLoadedState(
        tvDetail: _tvDetail,
        recommendationList: _tvRecommendations,
        isAddedToWatchlist: _isAddedToWatchlist,
        watchlistMessage: _watchlistMessage,
      ),
    );
  }

  Future<void> _removeWatchlist(
    RemoveWatchlistEvent event,
    Emitter<TvDetailState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.tvDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    _isAddedToWatchlist = await loadWatchlistStatus(event.tvDetail.id);

    emit(
      TvDetailLoadedState(
        tvDetail: _tvDetail,
        recommendationList: _tvRecommendations,
        isAddedToWatchlist: _isAddedToWatchlist,
        watchlistMessage: _watchlistMessage,
      ),
    );
  }

  Future<bool> loadWatchlistStatus(int id) async {
    return await getWatchListStatus.execute(id);
  }
}
