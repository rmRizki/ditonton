import 'package:tv/presentation/bloc/tv/tv_search/tv_search_bloc.dart';
import 'package:tv/presentation/pages/tv/tv_detail_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/search-tv';

  @override
  State<SearchTvPage> createState() => _SearchTvPageState();
}

class _SearchTvPageState extends State<SearchTvPage> {
  late final TvSearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = locator<TvSearchBloc>();
  }

  @override
  void dispose() {
    _searchBloc.close();
    super.dispose();
  }

  void _searchTv({required String query}) {
    _searchBloc.add(
      LoadTvSearchEvent(query: query),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search Tv Show'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (query) => _searchTv(query: query),
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
              BlocBuilder<TvSearchBloc, TvSearchState>(
                builder: (context, state) {
                  if (state is TvSearchInitial) {
                    _searchTv(query: '');
                  } else if (state is TvSearchLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvSearchFailureState) {
                    return Expanded(
                      child: Center(
                        key: Key('error_message'),
                        child: Text(state.errorMessage ?? ''),
                      ),
                    );
                  } else if (state is TvSearchLoadedState) {
                    final result = state.tvList ?? [];
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final tv = result[index];
                          return ItemCard(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                TvDetailPage.ROUTE_NAME,
                                arguments: tv.id,
                              );
                            },
                            title: tv.name,
                            overview: tv.overview,
                            posterPath: tv.posterPath,
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
