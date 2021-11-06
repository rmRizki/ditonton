import 'package:tv/domain/entities/genre/genre.dart';
import 'package:tv/domain/entities/season/season.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  final String? backdropPath;
  final List<Genre>? genres;
  final int id;
  final String? name;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final List<Season>? seasons;
  final String? status;
  final String? tagline;
  final double? voteAverage;
  final int? voteCount;

  TvDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originalName,
        overview,
        posterPath,
        seasons,
        status,
        tagline,
        voteAverage,
        voteCount,
      ];
}
