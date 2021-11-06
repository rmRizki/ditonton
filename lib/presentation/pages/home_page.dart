import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

class HomePage extends StatelessWidget {
  static const ROUTE_NAME = '/home';

  final _menuNotifier = ValueNotifier(Category.Movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                _menuNotifier.value = Category.Movie;
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Movie Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.live_tv),
              title: Text('Tv Show'),
              onTap: () {
                _menuNotifier.value = Category.Tv;
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Tv Show Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME);
              },
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: _menuNotifier,
          builder: (context, value, child) {
            var category = '';
            if (value == Category.Movie) {
              category = 'Movies';
            } else if (value == Category.Tv) {
              category = 'Tv Show';
            }
            return Text(category);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_menuNotifier.value == Category.Movie) {
                Navigator.pushNamed(context, SearchMoviePage.ROUTE_NAME);
              } else if (_menuNotifier.value == Category.Tv) {
                Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
              }
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: _menuNotifier,
          builder: (context, value, child) {
            if (value == Category.Movie) {
              return MoviePage();
            } else if (value == Category.Tv) {
              return TvPage();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
