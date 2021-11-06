import 'package:tv/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:tv/presentation/pages/tv/tv_detail_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> {
  late final WatchlistTvBloc _watchlistTvBloc;

  @override
  void initState() {
    super.initState();
    _watchlistTvBloc = locator<WatchlistTvBloc>();
  }

  @override
  void dispose() {
    _watchlistTvBloc.close();
    super.dispose();
  }

  void _loadWatchlist() {
    _watchlistTvBloc.add(LoadWatchlistTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _watchlistTvBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tv Watchlist'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
            builder: (context, state) {
              if (state is WatchlistTvInitial) {
                _loadWatchlist();
              } else if (state is WatchlistTvLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WatchlistTvFailureState) {
                return Center(
                  key: Key('error_message'),
                  child: Text(state.errorMessage ?? ''),
                );
              } else if (state is WatchlistTvLoadedState) {
                final tvList = state.tvList ?? [];
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = tvList[index];
                    return ItemCard(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          TvDetailPage.ROUTE_NAME,
                          arguments: tv.id,
                        ).then((_) => _loadWatchlist());
                      },
                      title: tv.name,
                      overview: tv.overview,
                      posterPath: tv.posterPath,
                    );
                  },
                  itemCount: tvList.length,
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
