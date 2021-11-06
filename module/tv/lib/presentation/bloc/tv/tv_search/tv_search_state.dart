part of 'tv_search_bloc.dart';

abstract class TvSearchState extends Equatable {
  const TvSearchState();

  @override
  List<Object?> get props => [];
}

class TvSearchInitial extends TvSearchState {}

class TvSearchLoadingState extends TvSearchState {}

class TvSearchLoadedState extends TvSearchState {
  final List<Tv>? tvList;

  TvSearchLoadedState({
    required this.tvList,
  });

  @override
  List<Object?> get props => [tvList];
}

class TvSearchFailureState extends TvSearchState {
  final String? errorMessage;

  TvSearchFailureState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
