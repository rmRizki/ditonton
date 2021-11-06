import 'package:movie/presentation/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:movie/presentation/pages/movie/movie_detail_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  late final PopularMovieBloc _popularMovieBloc;

  @override
  void initState() {
    super.initState();
    _popularMovieBloc = locator<PopularMovieBloc>();
  }

  @override
  void dispose() {
    _popularMovieBloc.close();
    super.dispose();
  }

  void _loadPopular() {
    _popularMovieBloc.add(LoadPopularMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _popularMovieBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Popular Movie'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
            builder: (context, state) {
              if (state is PopularMovieInitial) {
                _loadPopular();
              } else if (state is PopularMovieLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularMovieFailureState) {
                return Center(
                  key: Key('error_message'),
                  child: Text(state.errorMessage ?? ''),
                );
              } else if (state is PopularMovieLoadedState) {
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
                        ).then((_) => _loadPopular());
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
