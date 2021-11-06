import 'package:movie/presentation/bloc/movie/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:movie/presentation/pages/movie/movie_detail_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-movie';

  @override
  _NowPlayingMoviesPageState createState() => _NowPlayingMoviesPageState();
}

class _NowPlayingMoviesPageState extends State<NowPlayingMoviesPage> {
  late final NowPlayingMovieBloc _nowPlayingMovieBloc;

  @override
  void initState() {
    super.initState();
    _nowPlayingMovieBloc = locator<NowPlayingMovieBloc>();
  }

  @override
  void dispose() {
    _nowPlayingMovieBloc.close();
    super.dispose();
  }

  void _loadNowPlaying() {
    _nowPlayingMovieBloc.add(LoadNowPlayingMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _nowPlayingMovieBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Now Playing Movies'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
            builder: (context, state) {
              if (state is NowPlayingMovieInitial) {
                _loadNowPlaying();
              } else if (state is NowPlayingMovieLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowPlayingMovieFailureState) {
                return Center(
                  key: Key('error_message'),
                  child: Text(state.errorMessage ?? ''),
                );
              } else if (state is NowPlayingMovieLoadedState) {
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
                        ).then((_) => _loadNowPlaying());
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
