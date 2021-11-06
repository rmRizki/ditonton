import 'package:movie/presentation/bloc/movie/movie_search/movie_search_bloc.dart';
import 'package:movie/presentation/pages/movie/movie_detail_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/search-movie';

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  late final MovieSearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = locator<MovieSearchBloc>();
  }

  @override
  void dispose() {
    _searchBloc.close();
    super.dispose();
  }

  void _searchMovie({required String query}) {
    _searchBloc.add(
      LoadMovieSearchEvent(query: query),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search Movie'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (query) => _searchMovie(query: query),
                decoration: InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              SizedBox(height: 16),
              Text(
                'Search Result',
                style: Theme.of(context).textTheme.headline6,
              ),
              BlocBuilder<MovieSearchBloc, MovieSearchState>(
                builder: (context, state) {
                  if (state is MovieSearchInitial) {
                    _searchMovie(query: '');
                  } else if (state is MovieSearchLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieSearchFailureState) {
                    return Expanded(
                      child: Center(
                        key: Key('error_message'),
                        child: Text(state.errorMessage ?? ''),
                      ),
                    );
                  } else if (state is MovieSearchLoadedState) {
                    final result = state.movieList ?? [];
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final movie = result[index];
                          return ItemCard(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                MovieDetailPage.ROUTE_NAME,
                                arguments: movie.id,
                              );
                            },
                            title: movie.title,
                            overview: movie.overview,
                            posterPath: movie.posterPath,
                          );
                        },
                        itemCount: result.length,
                      ),
                    );
                  }
                  return Expanded(
                    child: Container(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
