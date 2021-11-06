import 'package:tv/presentation/bloc/tv/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:tv/presentation/pages/tv/tv_detail_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv';

  @override
  _NowPlayingTvPageState createState() => _NowPlayingTvPageState();
}

class _NowPlayingTvPageState extends State<NowPlayingTvPage> {
  late final NowPlayingTvBloc _nowPlayingTvBloc;

  @override
  void initState() {
    super.initState();
    _nowPlayingTvBloc = locator<NowPlayingTvBloc>();
  }

  @override
  void dispose() {
    _nowPlayingTvBloc.close();
    super.dispose();
  }

  void _loadNowPlaying() {
    _nowPlayingTvBloc.add(LoadNowPlayingTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _nowPlayingTvBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Now Playing Tv'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
            builder: (context, state) {
              if (state is NowPlayingTvInitial) {
                _loadNowPlaying();
              } else if (state is NowPlayingTvLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowPlayingTvFailureState) {
                return Center(
                  key: Key('error_message'),
                  child: Text(state.errorMessage ?? ''),
                );
              } else if (state is NowPlayingTvLoadedState) {
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
                        ).then((_) => _loadNowPlaying());
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
