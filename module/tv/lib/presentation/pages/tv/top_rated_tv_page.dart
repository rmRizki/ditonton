import 'package:tv/presentation/bloc/tv/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/tv/tv_detail_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvPageState createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  late final TopRatedTvBloc _topRatedTvBloc;

  @override
  void initState() {
    super.initState();
    _topRatedTvBloc = locator<TopRatedTvBloc>();
  }

  @override
  void dispose() {
    _topRatedTvBloc.close();
    super.dispose();
  }

  void _loadTopRated() {
    _topRatedTvBloc.add(LoadTopRatedTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _topRatedTvBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Top Rated Tv'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
            builder: (context, state) {
              if (state is TopRatedTvInitial) {
                _loadTopRated();
              } else if (state is TopRatedTvLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedTvFailureState) {
                return Center(
                  key: Key('error_message'),
                  child: Text(state.errorMessage ?? ''),
                );
              } else if (state is TopRatedTvLoadedState) {
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
                        ).then((_) => _loadTopRated());
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
