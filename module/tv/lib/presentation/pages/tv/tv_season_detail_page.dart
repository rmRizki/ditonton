import 'package:tv/presentation/bloc/tv/tv_season_detail/tv_season_detail_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-season-detail';

  final int id;
  final int seasonNumber;
  final String title;

  TvSeasonDetailPage({
    required this.id,
    required this.seasonNumber,
    required this.title,
  });

  @override
  _TvSeasonDetailPageState createState() => _TvSeasonDetailPageState();
}

class _TvSeasonDetailPageState extends State<TvSeasonDetailPage> {
  late final TvSeasonDetailBloc _seasonDetailBloc;

  @override
  void initState() {
    super.initState();
    _seasonDetailBloc = locator<TvSeasonDetailBloc>();
  }

  @override
  void dispose() {
    _seasonDetailBloc.close();
    super.dispose();
  }

  void _loadSeasonDetail() {
    _seasonDetailBloc.add(
      LoadTvSeasonDetailEvent(
        id: widget.id,
        seasonNumber: widget.seasonNumber,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _seasonDetailBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TvSeasonDetailBloc, TvSeasonDetailState>(
            builder: (context, state) {
              if (state is TvSeasonDetailInitial) {
                _loadSeasonDetail();
              } else if (state is TvSeasonDetailLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvSeasonDetailFailureState) {
                return Center(
                  key: Key('error_message'),
                  child: Text(state.errorMessage ?? ''),
                );
              } else if (state is TvSeasonDetailLoadedState) {
                final episodeList = state.seasonDetail?.episodes ?? [];
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final episode = episodeList[index];
                    return ItemCard(
                      onTap: () {},
                      title: episode.name,
                      overview: episode.overview,
                      posterPath: state.seasonDetail?.posterPath,
                    );
                  },
                  itemCount: episodeList.length,
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
