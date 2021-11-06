import 'dart:convert';

import 'package:tv/data/models/episode/episode_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tEpisodeModel = EpisodeModel.fromJson(
    json.decode(readJson('dummy_data/tv_season_detail.json'))['episodes'][0],
  );
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_season_detail.json'));
      // act
      final result = EpisodeModel.fromJson(jsonMap['episodes'][0]);
      // assert
      expect(result, tEpisodeModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        'air_date': '2011-05-22',
        'episode_number': 6,
        'id': 63061,
        'name': 'A Golden Crown',
        'overview':
            'While recovering from his battle with Jamie, Eddard is forced to run the kingdom while Robert goes hunting. Tyrion demands a trial by combat for his freedom. Viserys is losing his patience with Drogo.',
        'production_code': '106',
        'season_number': 1,
        'still_path': '/6FcfWGFlDyWZ2JvQi8uvkxbDx1z.jpg',
        'vote_average': 8.2,
        'vote_count': 78
      };
      // act
      final result = tEpisodeModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });

  group('toEntity', () {
    test('should be a subclass of Episode entity', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_season_detail.json'));
      final tEpisode = EpisodeModel.fromJson(jsonMap['episodes'][0]).toEntity();
      // act
      final result = tEpisodeModel.toEntity();
      // assert
      expect(result, tEpisode);
    });
  });
}
