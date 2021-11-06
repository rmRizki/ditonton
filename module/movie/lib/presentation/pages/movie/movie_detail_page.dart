import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:movie/domain/entities/genre/genre.dart';
import 'package:movie/domain/entities/movie/movie.dart';
import 'package:movie/domain/entities/movie/movie_detail.dart';
import 'package:movie/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-movie';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late final MovieDetailBloc _movieDetailBloc;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = locator<MovieDetailBloc>();
  }

  @override
  void dispose() {
    _movieDetailBloc.close();
    super.dispose();
  }

  void _loadMovie(int id) {
    _movieDetailBloc.add(LoadMovieDetailEvent(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _movieDetailBloc,
      child: Scaffold(
        body: BlocConsumer<MovieDetailBloc, MovieDetailState>(
          listener: (context, state) {
            if (state is MovieDetailLoadedState) {
              if (state.watchlistMessage != null) {
                final message = state.watchlistMessage!;

                if (message == MovieDetailBloc.watchlistAddSuccessMessage ||
                    message == MovieDetailBloc.watchlistRemoveSuccessMessage) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(message),
                      );
                    },
                  );
                }
              }
            }
          },
          builder: (context, state) {
            return BlocBuilder<MovieDetailBloc, MovieDetailState>(
              builder: (context, state) {
                if (state is MovieDetailInitial) {
                  _loadMovie(widget.id);
                } else if (state is MovieDetailLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieDetailFailureState) {
                  return Text(state.errorMessage ?? '');
                } else if (state is MovieDetailLoadedState) {
                  final movie = state.movieDetail;
                  if (movie != null) {
                    final movieRecommendations = state.recommendationList ?? [];
                    final isAddedToWatchlist =
                        state.isAddedToWatchlist ?? false;
                    return SafeArea(
                      child: DetailContent(
                        movie,
                        movieRecommendations,
                        isAddedToWatchlist,
                      ),
                    );
                  }
                }
                return Container();
              },
            );
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.movie, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  BlocProvider.of<MovieDetailBloc>(context,
                                          listen: false)
                                      .add(AddWatchlistEvent(
                                          movieDetail: movie));
                                } else {
                                  BlocProvider.of<MovieDetailBloc>(context,
                                          listen: false)
                                      .add(RemoveWatchlistEvent(
                                          movieDetail: movie));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            _buildRecommendationList(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildRecommendationList() {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieDetailFailureState) {
          return Text(state.errorMessage ?? '');
        } else if (state is MovieDetailLoadedState) {
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = recommendations[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        MovieDetailPage.ROUTE_NAME,
                        arguments: movie.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: recommendations.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
