import 'package:tv/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:tv/presentation/pages/tv/tv_detail_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvPageState createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  late final PopularTvBloc _popularTvBloc;

  @override
  void initState() {
    super.initState();
    _popularTvBloc = locator<PopularTvBloc>();
  }

  @override
  void dispose() {
    _popularTvBloc.close();
    super.dispose();
  }

  void _loadPopular() {
    _popularTvBloc.add(LoadPopularTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _popularTvBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Popular Tv'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularTvBloc, PopularTvState>(
            builder: (context, state) {
              if (state is PopularTvInitial) {
                _loadPopular();
              } else if (state is PopularTvLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularTvFailureState) {
                return Center(
                  key: Key('error_message'),
                  child: Text(state.errorMessage ?? ''),
                );
              } else if (state is PopularTvLoadedState) {
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
                        ).then((_) => _loadPopular());
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
