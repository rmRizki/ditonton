import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget _makeTestableItemCard(
    String? title,
    String? overview,
    String? posterPath,
  ) {
    return MaterialApp(
      home: Scaffold(
        body: ItemCard(
          onTap: () {},
          title: title,
          overview: overview,
          posterPath: posterPath,
        ),
      ),
    );
  }

  testWidgets('ItemCard has item', (WidgetTester tester) async {
    final testTitle = 'testTitle';
    final testOverview = 'testOverview';
    final testPosterpath = 'testOverview';

    await tester.pumpWidget(
        _makeTestableItemCard(testTitle, testOverview, testPosterpath));

    final titleFinder = find.text(testTitle);
    final overviewFinder = find.text(testOverview);

    expect(titleFinder, findsOneWidget);
    expect(overviewFinder, findsOneWidget);
  });

  testWidgets('ItemCard has null item', (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableItemCard(null, null, null));

    final emptyMovieTextFinder = find.text('-');
    expect(emptyMovieTextFinder, findsWidgets);
  });

  testWidgets('ItemCard has tap action', (WidgetTester tester) async {
    final testTitle = 'testTitle';
    final testOverview = 'testOverview';
    final testPosterpath = 'testOverview';

    await tester.pumpWidget(
        _makeTestableItemCard(testTitle, testOverview, testPosterpath));

    final titleFinder = find.text(testTitle);
    await tester.tap(titleFinder);
  });
}
