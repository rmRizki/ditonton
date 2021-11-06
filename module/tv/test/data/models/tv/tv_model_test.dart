import 'dart:convert';

import 'package:tv/data/models/tv/tv_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvModel = TvModel.fromJson(
    json.decode(readJson('dummy_data/on_the_air.json'))['results'][0],
  );
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air.json'));
      // act
      final result = TvModel.fromJson(jsonMap['results'][0]);
      // assert
      expect(result, tTvModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        "poster_path": "/path.jpg",
        "popularity": 8.464776,
        "id": 67386,
        "backdrop_path": null,
        "vote_average": 0,
        "overview": "overview",
        "first_air_date": "2016-08-29",
        "origin_country": ["FR"],
        "genre_ids": [16, 35],
        "original_language": "fr",
        "vote_count": 0,
        "name": "Blaise",
        "original_name": "Blaise"
      };
      // act
      final result = tTvModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });

  group('toEntity', () {
    test('should be a subclass of Tv entity', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air.json'));
      final tSeason = TvModel.fromJson(jsonMap['results'][0]).toEntity();
      // act
      final result = tTvModel.toEntity();
      // assert
      expect(result, tSeason);
    });
  });
}
