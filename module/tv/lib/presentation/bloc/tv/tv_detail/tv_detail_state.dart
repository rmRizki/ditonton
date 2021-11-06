part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object?> get props => [];
}

class TvDetailInitial extends TvDetailState {}

class TvDetailLoadingState extends TvDetailState {}

class TvDetailLoadedState extends TvDetailState {
  final TvDetail? tvDetail;
  final List<Tv>? recommendationList;
  final bool? isAddedToWatchlist;
  final String? watchlistMessage;

  TvDetailLoadedState({
    required this.tvDetail,
    this.recommendationList,
    this.isAddedToWatchlist,
    this.watchlistMessage,
  });

  @override
  List<Object?> get props => [
        tvDetail,
        recommendationList,
        isAddedToWatchlist,
        watchlistMessage,
      ];
}

class TvDetailFailureState extends TvDetailState {
  final String? errorMessage;

  TvDetailFailureState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
