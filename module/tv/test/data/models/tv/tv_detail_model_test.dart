import 'dart:convert';

import 'package:tv/data/models/tv/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvDetailResponse = TvDetailResponse.fromJson(
    json.decode(readJson('dummy_data/tv_detail.json')),
  );
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_detail.json'));
      // act
      final result = TvDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvDetailResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        'backdrop_path': '/suopoADq0k8YZr4dQXcU6pToj6s.jpg',
        'genres': [
          {"id": 1, "name": "Action"},
          {'id': 9648, 'name': 'Mystery'}
        ],
        'id': 1399,
        'name': 'Game of Thrones',
        'number_of_episodes': 73,
        'number_of_seasons': 8,
        'original_name': 'Game of Thrones',
        'overview':
            'Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night\'s Watch, is all that stands between the realms of men and icy horrors beyond.',
        'poster_path': '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
        'seasons': [
          {
            'air_date': '2019-04-14',
            'episode_count': 6,
            'id': 107971,
            'name': 'Season 8',
            'overview':
                'The Great War has come, the Wall has fallen and the Night King\'s army of the dead marches towards Westeros. The end is here, but who will take the Iron Throne?',
            'poster_path': '/39FHkTLnNMjMVXdIDwZN8SxYqD6.jpg',
            'season_number': 8
          }
        ],
        'status': 'Ended',
        'tagline': 'Winter Is Coming',
        'vote_average': 8.3,
        'vote_count': 11504
      };
      // act
      final result = tTvDetailResponse.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });

  group('toEntity', () {
    test('should be a subclass of tv entity', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_detail.json'));
      final tSeasonDetail = TvDetailResponse.fromJson(jsonMap).toEntity();
      // act
      final result = tTvDetailResponse.toEntity();
      // assert
      expect(result, tSeasonDetail);
    });
  });
}
