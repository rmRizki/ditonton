import 'dart:convert';

import 'package:tv/data/models/season/season_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tSeasonModel = SeasonModel.fromJson(
    json.decode(readJson('dummy_data/tv_detail.json'))['seasons'][0],
  );
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_detail.json'));
      // act
      final result = SeasonModel.fromJson(jsonMap['seasons'][0]);
      // assert
      expect(result, tSeasonModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        'air_date': '2019-04-14',
        'episode_count': 6,
        'id': 107971,
        'name': 'Season 8',
        'overview':
            'The Great War has come, the Wall has fallen and the Night King\'s army of the dead marches towards Westeros. The end is here, but who will take the Iron Throne?',
        'poster_path': '/39FHkTLnNMjMVXdIDwZN8SxYqD6.jpg',
        'season_number': 8
      };
      // act
      final result = tSeasonModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });

  group('toEntity', () {
    test('should be a subclass of Tv entity', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_detail.json'));
      final tSeason = SeasonModel.fromJson(jsonMap['seasons'][0]).toEntity();
      // act
      final result = tSeasonModel.toEntity();
      // assert
      expect(result, tSeason);
    });
  });
}
