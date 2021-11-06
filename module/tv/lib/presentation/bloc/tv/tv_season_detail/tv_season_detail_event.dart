part of 'tv_season_detail_bloc.dart';

abstract class TvSeasonDetailEvent extends Equatable {
  const TvSeasonDetailEvent();
}

class LoadTvSeasonDetailEvent extends TvSeasonDetailEvent {
  final int id;
  final int seasonNumber;

  LoadTvSeasonDetailEvent({
    required this.id,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [
        id,
        seasonNumber,
      ];
}
