import 'package:core/core.dart';
import 'package:tv/presentation/bloc/tv/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/tv/now_playing_tv_page.dart';
import 'package:tv/presentation/pages/tv/popular_tv_page.dart';
import 'package:tv/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:tv/presentation/widgets/tv_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvPage extends StatefulWidget {
  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  late final NowPlayingTvBloc _nowPlayingTvBloc;
  late final PopularTvBloc _popularTvBloc;
  late final TopRatedTvBloc _topRatedTvBloc;

  @override
  void initState() {
    super.initState();
    _nowPlayingTvBloc = locator<NowPlayingTvBloc>();
    _popularTvBloc = locator<PopularTvBloc>();
    _topRatedTvBloc = locator<TopRatedTvBloc>();
  }

  @override
  void dispose() {
    _nowPlayingTvBloc.close();
    _popularTvBloc.close();
    _topRatedTvBloc.close();
    super.dispose();
  }

  void _loadNowPlaying() {
    _nowPlayingTvBloc.add(LoadNowPlayingTvEvent());
  }

  void _loadPopular() {
    _popularTvBloc.add(LoadPopularTvEvent());
  }

  void _loadTopRated() {
    _topRatedTvBloc.add(LoadTopRatedTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _nowPlayingTvBloc),
        BlocProvider(create: (context) => _popularTvBloc),
        BlocProvider(create: (context) => _topRatedTvBloc),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
              title: 'Now Playing',
              onTap: () =>
                  Navigator.pushNamed(context, NowPlayingTvPage.ROUTE_NAME),
            ),
            BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
              builder: (context, state) {
                if (state is NowPlayingTvInitial) {
                  _loadNowPlaying();
                } else if (state is NowPlayingTvLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingTvFailureState) {
                  return Text(state.errorMessage ?? '');
                } else if (state is NowPlayingTvLoadedState) {
                  return TvList(state.tvList ?? []);
                }
                return Container();
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularTvBloc, PopularTvState>(
              builder: (context, state) {
                if (state is PopularTvInitial) {
                  _loadPopular();
                } else if (state is PopularTvLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvFailureState) {
                  return Text(state.errorMessage ?? '');
                } else if (state is PopularTvLoadedState) {
                  return TvList(state.tvList ?? []);
                }
                return Container();
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
              builder: (context, state) {
                if (state is TopRatedTvInitial) {
                  _loadTopRated();
                } else if (state is TopRatedTvLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvFailureState) {
                  return Text(state.errorMessage ?? '');
                } else if (state is TopRatedTvLoadedState) {
                  return TvList(state.tvList ?? []);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
