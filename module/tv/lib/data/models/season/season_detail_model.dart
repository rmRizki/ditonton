import 'package:tv/data/models/episode/episode_model.dart';
import 'package:tv/domain/entities/season/season_detail.dart';
import 'package:equatable/equatable.dart';

class SeasonDetailResponse extends Equatable {
  final String? airDate;
  final List<EpisodeModel>? episodes;
  final String? name;
  final String? overview;
  final int? id;
  final String? posterPath;
  final int? seasonNumber;

  SeasonDetailResponse({
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory SeasonDetailResponse.fromJson(Map<String, dynamic> json) =>
      SeasonDetailResponse(
        airDate: json['air_date'],
        episodes: List<EpisodeModel>.from(
          json["episodes"].map((x) => EpisodeModel.fromJson(x)),
        ),
        name: json['name'],
        overview: json['overview'],
        id: json['id'],
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['air_date'] = this.airDate;
    if (this.episodes != null) {
      data['episodes'] = this.episodes!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['overview'] = this.overview;
    data['id'] = this.id;
    data['poster_path'] = this.posterPath;
    data['season_number'] = this.seasonNumber;
    return data;
  }

  SeasonDetail toEntity() {
    return SeasonDetail(
      airDate: this.airDate,
      episodes: this.episodes?.map((episode) => episode.toEntity()).toList(),
      name: this.name,
      overview: this.overview,
      id: this.id,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
    );
  }

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
