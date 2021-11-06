import 'dart:convert';

import 'package:tv/data/models/genre/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tGenreModel = GenreModel.fromJson(
    json.decode(readJson('dummy_data/tv_detail.json'))['genres'][0],
  );
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_detail.json'));
      // act
      final result = GenreModel.fromJson(jsonMap['genres'][0]);
      // assert
      expect(result, tGenreModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tGenreModel.toJson();
      // assert
      final expectedJsonMap = {"id": 1, "name": "Action"};
      expect(result, expectedJsonMap);
    });
  });
}
