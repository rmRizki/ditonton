import 'package:tv/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  final String? posterPath;
  final num? popularity;
  final int? id;
  final String? backdropPath;
  final num? voteAverage;
  final String? overview;
  final String? firstAirDate;
  final List<String>? originCountry;
  final List<int>? genreIds;
  final String? originalLanguage;
  final int? voteCount;
  final String? name;
  final String? originalName;

  TvModel({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        posterPath: json['poster_path'],
        popularity: json['popularity'],
        id: json['id'],
        backdropPath: json['backdrop_path'],
        voteAverage: json['vote_average'],
        overview: json['overview'],
        firstAirDate: json['first_air_date'],
        originCountry: json['origin_country'].cast<String>(),
        genreIds: json['genre_ids'].cast<int>(),
        originalLanguage: json['original_language'],
        voteCount: json['vote_count'],
        name: json['name'],
        originalName: json['original_name'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poster_path'] = this.posterPath;
    data['popularity'] = this.popularity;
    data['id'] = this.id;
    data['backdrop_path'] = this.backdropPath;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['first_air_date'] = this.firstAirDate;
    data['origin_country'] = this.originCountry;
    data['genre_ids'] = this.genreIds;
    data['original_language'] = this.originalLanguage;
    data['vote_count'] = this.voteCount;
    data['name'] = this.name;
    data['original_name'] = this.originalName;
    return data;
  }

  Tv toEntity() {
    return Tv(
      posterPath: this.posterPath,
      popularity: this.popularity,
      id: this.id,
      backdropPath: this.backdropPath,
      voteAverage: this.voteAverage,
      overview: this.overview,
      firstAirDate: this.firstAirDate,
      originCountry: this.originCountry,
      genreIds: this.genreIds,
      originalLanguage: this.originalLanguage,
      voteCount: this.voteCount,
      name: this.name,
      originalName: this.originalName,
    );
  }

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        originCountry,
        genreIds,
        originalLanguage,
        voteCount,
        name,
        originalName,
      ];
}
