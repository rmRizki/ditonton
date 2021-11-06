part of 'tv_season_detail_bloc.dart';

abstract class TvSeasonDetailState extends Equatable {
  const TvSeasonDetailState();

  @override
  List<Object?> get props => [];
}

class TvSeasonDetailInitial extends TvSeasonDetailState {}

class TvSeasonDetailLoadingState extends TvSeasonDetailState {}

class TvSeasonDetailLoadedState extends TvSeasonDetailState {
  final SeasonDetail? seasonDetail;

  TvSeasonDetailLoadedState({
    required this.seasonDetail,
  });

  @override
  List<Object?> get props => [seasonDetail];
}

class TvSeasonDetailFailureState extends TvSeasonDetailState {
  final String? errorMessage;

  TvSeasonDetailFailureState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
