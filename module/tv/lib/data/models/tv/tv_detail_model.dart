import 'package:tv/data/models/genre/genre_model.dart';
import 'package:tv/data/models/season/season_model.dart';
import 'package:tv/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable {
  final String? backdropPath;
  final List<GenreModel>? genres;
  final int id;
  final String? name;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final List<SeasonModel>? seasons;
  final String? status;
  final String? tagline;
  final double? voteAverage;
  final int? voteCount;

  TvDetailResponse({
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

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        backdropPath: json['backdrop_path'],
        genres: List<GenreModel>.from(
          json["genres"].map((x) => GenreModel.fromJson(x)),
        ),
        id: json['id'],
        name: json['name'],
        numberOfEpisodes: json['number_of_episodes'],
        numberOfSeasons: json['number_of_seasons'],
        originalName: json['original_name'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        seasons: List<SeasonModel>.from(
          json["seasons"].map((x) => SeasonModel.fromJson(x)),
        ),
        status: json['status'],
        tagline: json['tagline'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path'] = this.backdropPath;
    if (this.genres != null) {
      data['genres'] = this.genres!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['number_of_episodes'] = this.numberOfEpisodes;
    data['number_of_seasons'] = this.numberOfSeasons;
    data['original_name'] = this.originalName;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    if (this.seasons != null) {
      data['seasons'] = this.seasons!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['tagline'] = this.tagline;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    return data;
  }

  TvDetail toEntity() {
    return TvDetail(
      backdropPath: this.backdropPath,
      genres: this.genres?.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      name: this.name,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      originalName: this.originalName,
      overview: this.overview,
      posterPath: this.posterPath,
      seasons: this.seasons?.map((season) => season.toEntity()).toList(),
      status: this.status,
      tagline: this.tagline,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

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
