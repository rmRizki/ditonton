part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object?> get props => [];
}

class WatchlistTvInitial extends WatchlistTvState {}

class WatchlistTvLoadingState extends WatchlistTvState {}

class WatchlistTvLoadedState extends WatchlistTvState {
  final List<Tv>? tvList;

  WatchlistTvLoadedState({
    required this.tvList,
  });

  @override
  List<Object?> get props => [tvList];
}

class WatchlistTvFailureState extends WatchlistTvState {
  final String? errorMessage;

  WatchlistTvFailureState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
