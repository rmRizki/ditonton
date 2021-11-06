import 'dart:convert';

import 'package:tv/data/models/season/season_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tSeasonDetailResponse = SeasonDetailResponse.fromJson(
    json.decode(readJson('dummy_data/tv_season_detail.json')),
  );
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_season_detail.json'));
      // act
      final result = SeasonDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeasonDetailResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        'air_date': '2011-04-17',
        'episodes': [
          {
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
          }
        ],
        'name': 'Season 1',
        'overview':
            'Trouble is brewing in the Seven Kingdoms of Westeros. For the driven inhabitants of this visionary world, control of Westeros\' Iron Throne holds the lure of great power. But in a land where the seasons can last a lifetime, winter is coming...and beyond the Great Wall that protects them, an ancient evil has returned. In Season One, the story centers on three primary areas: the Stark and the Lannister families, whose designs on controlling the throne threaten a tenuous peace; the dragon princess Daenerys, heir to the former dynasty, who waits just over the Narrow Sea with her malevolent brother Viserys; and the Great Wall--a massive barrier of ice where a forgotten danger is stirring.',
        'id': 3624,
        'poster_path': '/zwaj4egrhnXOBIit1tyb4Sbt3KP.jpg',
        'season_number': 1
      };
      // act
      final result = tSeasonDetailResponse.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });

  group('toEntity', () {
    test('should be a subclass of SeasonDetail  entity', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_season_detail.json'));
      final tSeasonDetail = SeasonDetailResponse.fromJson(jsonMap).toEntity();
      // act
      final result = tSeasonDetailResponse.toEntity();
      // assert
      expect(result, tSeasonDetail);
    });
  });
}
