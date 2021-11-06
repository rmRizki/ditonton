import 'package:movie/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/movie/movie_detail_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> {
  late final WatchlistMovieBloc _watchlistMovieBloc;

  @override
  void initState() {
    super.initState();
    _watchlistMovieBloc = locator<WatchlistMovieBloc>();
  }

  @override
  void dispose() {
    _watchlistMovieBloc.close();
    super.dispose();
  }

  void _loadWatchlist() {
    _watchlistMovieBloc.add(LoadWatchlistMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _watchlistMovieBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Movie Watchlist'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
            builder: (context, state) {
              if (state is WatchlistMovieInitial) {
                _loadWatchlist();
              } else if (state is WatchlistMovieLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WatchlistMovieFailureState) {
                return Center(
                  key: Key('error_message'),
                  child: Text(state.errorMessage ?? ''),
                );
              } else if (state is WatchlistMovieLoadedState) {
                final movieList = state.movieList ?? [];
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = movieList[index];
                    return ItemCard(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          MovieDetailPage.ROUTE_NAME,
                          arguments: movie.id,
                        ).then((_) => _loadWatchlist());
                      },
                      title: movie.title,
                      overview: movie.overview,
                      posterPath: movie.posterPath,
                    );
                  },
                  itemCount: movieList.length,
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
