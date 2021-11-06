part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();
}

class LoadTvDetailEvent extends TvDetailEvent {
  final int id;

  LoadTvDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class AddWatchlistEvent extends TvDetailEvent {
  final TvDetail tvDetail;

  AddWatchlistEvent({required this.tvDetail});

  @override
  List<Object> get props => [tvDetail];
}

class RemoveWatchlistEvent extends TvDetailEvent {
  final TvDetail tvDetail;

  RemoveWatchlistEvent({required this.tvDetail});

  @override
  List<Object> get props => [tvDetail];
}
