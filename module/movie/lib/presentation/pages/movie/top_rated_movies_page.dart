import 'package:movie/presentation/bloc/movie/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movie/presentation/pages/movie/movie_detail_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  late final TopRatedMovieBloc _topRatedMovieBloc;

  @override
  void initState() {
    super.initState();
    _topRatedMovieBloc = locator<TopRatedMovieBloc>();
  }

  @override
  void dispose() {
    _topRatedMovieBloc.close();
    super.dispose();
  }

  void _loadTopRated() {
    _topRatedMovieBloc.add(LoadTopRatedMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _topRatedMovieBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Top Rated Movie'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
            builder: (context, state) {
              if (state is TopRatedMovieInitial) {
                _loadTopRated();
              } else if (state is TopRatedMovieLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedMovieFailureState) {
                return Center(
                  key: Key('error_message'),
                  child: Text(state.errorMessage ?? ''),
                );
              } else if (state is TopRatedMovieLoadedState) {
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
                        ).then((_) => _loadTopRated());
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
