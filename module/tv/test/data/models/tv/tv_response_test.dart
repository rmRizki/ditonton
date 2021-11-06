import 'dart:convert';
import 'package:tv/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../json_reader.dart';

void main() {
  final tTvResponse =
      TvResponse.fromJson(json.decode(readJson('dummy_data/on_the_air.json')));
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponse.toJson();
      // assert
      final expectedJsonMap = {
        'results': [
          {
            'poster_path': '/path.jpg',
            'popularity': 8.464776,
            'id': 67386,
            'backdrop_path': null,
            'vote_average': 0,
            'overview': 'overview',
            'first_air_date': '2016-08-29',
            'origin_country': ['FR'],
            'genre_ids': [16, 35],
            'original_language': 'fr',
            'vote_count': 0,
            'name': 'Blaise',
            'original_name': 'Blaise'
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
