import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:ditonton/presentation/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        colorScheme: kColorScheme,
        primaryColor: kRichBlack,
        scaffoldBackgroundColor: kRichBlack,
        textTheme: kTextTheme,
      ),
      home: HomePage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HomePage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => HomePage());
          case NowPlayingMoviesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => NowPlayingMoviesPage());
          case PopularMoviesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
          case TopRatedMoviesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
          case MovieDetailPage.ROUTE_NAME:
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => MovieDetailPage(id: id),
            );
          case SearchMoviePage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => SearchMoviePage());
          case WatchlistMoviesPage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
          case NowPlayingTvPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => NowPlayingTvPage());
          case PopularTvPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => PopularTvPage());
          case TopRatedTvPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
          case TvDetailPage.ROUTE_NAME:
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => TvDetailPage(id: id),
            );
          case TvSeasonDetailPage.ROUTE_NAME:
            final arguments = settings.arguments as Map<String, dynamic>;
            final id = arguments['id'];
            final seasonNumber = arguments['season_number'];
            final title = arguments['title'];
            return MaterialPageRoute(
              builder: (_) => TvSeasonDetailPage(
                id: id,
                seasonNumber: seasonNumber,
                title: title,
              ),
            );
          case SearchTvPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => SearchTvPage());
          case WatchlistTvPage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => WatchlistTvPage());
          case AboutPage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => AboutPage());
          default:
            return MaterialPageRoute(builder: (_) {
              return Scaffold(
                body: Center(
                  child: Text('Page not found :('),
                ),
              );
            });
        }
      },
    );
  }
}
