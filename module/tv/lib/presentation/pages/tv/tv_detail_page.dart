import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/genre/genre.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/entities/tv/tv_detail.dart';
import 'package:tv/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/pages/tv/tv_season_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  late final TvDetailBloc _tvDetailBloc;

  @override
  void initState() {
    super.initState();
    _tvDetailBloc = locator<TvDetailBloc>();
  }

  @override
  void dispose() {
    _tvDetailBloc.close();
    super.dispose();
  }

  void _loadTv(int id) {
    _tvDetailBloc.add(LoadTvDetailEvent(id: id));
  }

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _tvDetailBloc,
      child: Scaffold(
        body: BlocConsumer<TvDetailBloc, TvDetailState>(
          listener: (context, state) {
            if (state is TvDetailLoadedState) {
              if (state.watchlistMessage != null) {
                final message = state.watchlistMessage!;

                if (message == TvDetailBloc.watchlistAddSuccessMessage ||
                    message == TvDetailBloc.watchlistRemoveSuccessMessage) {
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
            return BlocBuilder<TvDetailBloc, TvDetailState>(
              builder: (context, state) {
                if (state is TvDetailInitial) {
                  _loadTv(widget.id);
                } else if (state is TvDetailLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvDetailFailureState) {
                  return Text(state.errorMessage ?? '');
                } else if (state is TvDetailLoadedState) {
                  final tv = state.tvDetail;
                  if (tv != null) {
                    final tvRecommendations = state.recommendationList ?? [];
                    final isAddedToWatchlist =
                        state.isAddedToWatchlist ?? false;
                    return SafeArea(
                      child: DetailContent(
                        tv,
                        tvRecommendations,
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
  final TvDetail tv;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.tv, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
                              tv.name ?? '-',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  BlocProvider.of<TvDetailBloc>(context,
                                          listen: false)
                                      .add(AddWatchlistEvent(tvDetail: tv));
                                } else {
                                  BlocProvider.of<TvDetailBloc>(context,
                                          listen: false)
                                      .add(RemoveWatchlistEvent(tvDetail: tv));
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
                              _showGenres(tv.genres ?? []),
                            ),
                            Text(
                              _showDuration(
                                tv.numberOfSeasons ?? 0,
                                tv.numberOfEpisodes ?? 0,
                              ),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: (tv.voteAverage ?? 0.0) / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              tv.overview ?? '-',
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Season',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            _buildSeasonList(),
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

  Widget _buildSeasonList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final season = tv.seasons?[index];
        return Column(
          children: [
            Divider(color: Colors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    season?.name ?? '-',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      TvSeasonDetailPage.ROUTE_NAME,
                      arguments: {
                        'id': tv.id,
                        'season_number': season?.seasonNumber ?? 0,
                        'title': season?.name ?? '-',
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Text('See Episodes'),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
      itemCount: tv.seasons?.length,
      shrinkWrap: true,
    );
  }

  Widget _buildRecommendationList() {
    return BlocBuilder<TvDetailBloc, TvDetailState>(
      builder: (context, state) {
        if (state is TvDetailLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvDetailFailureState) {
          return Text(state.errorMessage ?? '');
        } else if (state is TvDetailLoadedState) {
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final tv = recommendations[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        TvDetailPage.ROUTE_NAME,
                        arguments: tv.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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

  String _showDuration(int season, int episode) {
    return '$season ${season > 1 ? 'seasons' : 'season'}, $episode ${episode > 1 ? 'episodes' : 'episode'}';
  }
}
