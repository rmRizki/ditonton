import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ThemeData tThemeData;

  setUp(() {
    tThemeData = ThemeData(textTheme: kTextTheme);
  });

  group('ThemeData', () {
    test('should return expected themeData', () {
      final result = ThemeData(textTheme: kTextTheme);

      expect(result, tThemeData);
    });

    test('should return expected textTheme', () {
      final tTextTheme = tThemeData.textTheme;
      final result = ThemeData(textTheme: kTextTheme).textTheme;

      expect(result, tTextTheme);
    });
  });
}
