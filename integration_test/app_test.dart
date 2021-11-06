import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:ditonton/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Test movie and tv show feature', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // tap drawer and verify menu
      final drawer = find.byIcon(Icons.menu);
      expect(drawer, findsOneWidget);
      await tester.tap(drawer);
      await tester.pumpAndSettle();
      final movieMenu = find.widgetWithText(ListTile, 'Movies');
      final movieWatchlistMenu =
          find.widgetWithText(ListTile, 'Movie Watchlist');
      final tvMenu = find.widgetWithText(ListTile, 'Tv Show');
      final tvWatchlistMenu =
          find.widgetWithText(ListTile, 'Tv Show Watchlist');
      final aboutMenu = find.widgetWithText(ListTile, 'About');
      expect(movieMenu, findsOneWidget);
      expect(movieWatchlistMenu, findsOneWidget);
      expect(tvMenu, findsOneWidget);
      expect(tvWatchlistMenu, findsOneWidget);
      expect(aboutMenu, findsOneWidget);

      // tap movie menu and verify if page is movie
      await tester.tap(movieMenu);
      await tester.pumpAndSettle();
      expect(find.text('Movies'), findsOneWidget);
      expect(find.text('Now Playing'), findsOneWidget);
      expect(find.text('Popular'), findsOneWidget);
      expect(find.text('Top Rated'), findsOneWidget);
      expect(find.text('See More'), findsWidgets);
      expect(find.byIcon(Icons.arrow_forward_ios), findsWidgets);

      // search movie with query "venom"
      final searchButton = find.byIcon(Icons.search);
      expect(searchButton, findsOneWidget);
      await tester.tap(searchButton);
      await tester.pumpAndSettle();
      expect(find.text('Search Movie'), findsOneWidget);
      expect(find.text('Search title'), findsOneWidget);
      expect(find.text('Search Result'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'venom');
      await tester.pumpAndSettle(Duration(milliseconds: 500));
      expect(find.byType(ItemCard), findsWidgets);

      // tap first search result element then add to watchlist
      final movieSearchResult = find.widgetWithText(ItemCard, 'Venom').first;
      await tester.tap(movieSearchResult);
      await tester.pumpAndSettle();
      final watchlistButtonIcon = find.byIcon(Icons.add);
      expect(watchlistButtonIcon, findsOneWidget);
      await tester.tap(watchlistButtonIcon);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // go back to home, open drawer and tap movie watchlist menu
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(drawer);
      await tester.pumpAndSettle();
      await tester.tap(movieWatchlistMenu);
      await tester.pumpAndSettle();

      // tap watchlist item and remove from watchlist
      final movieWatchlistResult = find.widgetWithText(ItemCard, 'Venom');
      await tester.tap(movieWatchlistResult);
      await tester.pumpAndSettle();
      final removeWatchlistButtonIcon = find.byIcon(Icons.check);
      expect(removeWatchlistButtonIcon, findsOneWidget);
      await tester.tap(removeWatchlistButtonIcon);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(movieWatchlistResult, findsNothing);

      // go back to home open drawer
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(drawer);
      await tester.pumpAndSettle();

      // tap tv menu and verify if page is tv
      await tester.tap(tvMenu);
      await tester.pumpAndSettle();
      expect(find.text('Tv Show'), findsOneWidget);
      expect(find.text('Now Playing'), findsOneWidget);
      expect(find.text('Popular'), findsOneWidget);
      expect(find.text('Top Rated'), findsOneWidget);
      expect(find.text('See More'), findsWidgets);
      expect(find.byIcon(Icons.arrow_forward_ios), findsWidgets);

      // search tv with query "doraemon"
      expect(searchButton, findsOneWidget);
      await tester.tap(searchButton);
      await tester.pumpAndSettle();
      expect(find.text('Search Tv Show'), findsOneWidget);
      expect(find.text('Search title'), findsOneWidget);
      expect(find.text('Search Result'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'doraemon');
      await tester.pumpAndSettle(Duration(milliseconds: 500));
      expect(find.byType(ItemCard), findsWidgets);

      // tap first search result element then add to watchlist
      final tvSearchResult = find.widgetWithText(ItemCard, 'Doraemon').first;
      await tester.tap(tvSearchResult);
      await tester.pumpAndSettle();
      expect(watchlistButtonIcon, findsOneWidget);
      await tester.tap(watchlistButtonIcon);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // go back to home, open drawer and tap tv watchlist menu
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(drawer);
      await tester.pumpAndSettle();
      await tester.tap(tvWatchlistMenu);
      await tester.pumpAndSettle();

      // tap watchlist item and remove from watchlist
      final tvWatchlistResult = find.widgetWithText(ItemCard, 'Doraemon');
      await tester.tap(tvWatchlistResult);
      await tester.pumpAndSettle();
      expect(removeWatchlistButtonIcon, findsOneWidget);
      await tester.tap(removeWatchlistButtonIcon);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(tvWatchlistResult, findsNothing);
    });
  });
}
