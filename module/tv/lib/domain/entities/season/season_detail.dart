import 'package:tv/domain/entities/episode/episode.dart';
import 'package:equatable/equatable.dart';

class SeasonDetail extends Equatable {
  final String? airDate;
  final List<Episode>? episodes;
  final String? name;
  final String? overview;
  final int? id;
  final String? posterPath;
  final int? seasonNumber;

  SeasonDetail({
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [
        airDate,
        episodes,
        name,
        overview,
        id,
        posterPath,
        seasonNumber,
      ];
}
