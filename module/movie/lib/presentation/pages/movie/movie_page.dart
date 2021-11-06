import 'package:core/core.dart';
import 'package:movie/presentation/bloc/movie/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:movie/presentation/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/movie/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movie/presentation/pages/movie/now_playing_movies_page.dart';
import 'package:movie/presentation/pages/movie/popular_movies_page.dart';
import 'package:movie/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:movie/presentation/widgets/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late final NowPlayingMovieBloc _nowPlayingMovieBloc;
  late final PopularMovieBloc _popularMovieBloc;
  late final TopRatedMovieBloc _topRatedMovieBloc;

  @override
  void initState() {
    super.initState();
    _nowPlayingMovieBloc = locator<NowPlayingMovieBloc>();
    _popularMovieBloc = locator<PopularMovieBloc>();
    _topRatedMovieBloc = locator<TopRatedMovieBloc>();
  }

  @override
  void dispose() {
    _nowPlayingMovieBloc.close();
    _popularMovieBloc.close();
    _topRatedMovieBloc.close();
    super.dispose();
  }

  void _loadNowPlaying() {
    _nowPlayingMovieBloc.add(LoadNowPlayingMovieEvent());
  }

  void _loadPopular() {
    _popularMovieBloc.add(LoadPopularMovieEvent());
  }

  void _loadTopRated() {
    _topRatedMovieBloc.add(LoadTopRatedMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _nowPlayingMovieBloc),
        BlocProvider(create: (context) => _popularMovieBloc),
        BlocProvider(create: (context) => _topRatedMovieBloc),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
              title: 'Now Playing',
              onTap: () =>
                  Navigator.pushNamed(context, NowPlayingMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
              builder: (context, state) {
                if (state is NowPlayingMovieInitial) {
                  _loadNowPlaying();
                } else if (state is NowPlayingMovieLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingMovieFailureState) {
                  return Text(state.errorMessage ?? '');
                } else if (state is NowPlayingMovieLoadedState) {
                  return MovieList(state.movieList ?? []);
                }
                return Container();
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularMovieBloc, PopularMovieState>(
              builder: (context, state) {
                if (state is PopularMovieInitial) {
                  _loadPopular();
                } else if (state is PopularMovieLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMovieFailureState) {
                  return Text(state.errorMessage ?? '');
                } else if (state is PopularMovieLoadedState) {
                  return MovieList(state.movieList ?? []);
                }
                return Container();
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
              builder: (context, state) {
                if (state is TopRatedMovieInitial) {
                  _loadTopRated();
                } else if (state is TopRatedMovieLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMovieFailureState) {
                  return Text(state.errorMessage ?? '');
                } else if (state is TopRatedMovieLoadedState) {
                  return MovieList(state.movieList ?? []);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
