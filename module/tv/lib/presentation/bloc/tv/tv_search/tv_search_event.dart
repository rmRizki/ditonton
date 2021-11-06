part of 'tv_search_bloc.dart';

abstract class TvSearchEvent extends Equatable {
  const TvSearchEvent();
}

class LoadTvSearchEvent extends TvSearchEvent {
  final String query;

  LoadTvSearchEvent({required this.query});

  @override
  List<Object> get props => [query];
}
