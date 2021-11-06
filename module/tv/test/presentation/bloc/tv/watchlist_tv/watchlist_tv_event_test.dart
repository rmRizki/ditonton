import 'package:tv/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadWatchlistTvEvent', () {
    final tLoadWatchlistTvEvent = LoadWatchlistTvEvent();

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadWatchlistTvEvent.props, []);
      },
    );
  });
}
