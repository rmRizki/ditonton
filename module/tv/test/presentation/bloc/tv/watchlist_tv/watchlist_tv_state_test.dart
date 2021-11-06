import 'package:tv/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('WatchlistTvInitial', () {
    final tInitial = WatchlistTvInitial();

    test(
      'make sure props value is []',
      () async {
        // assert
        expect(
          tInitial.props,
          [],
        );
      },
    );
  });

  group('WatchlistTvLoadingState', () {
    final tLoadingState = WatchlistTvLoadingState();

    test(
      'make sure props value is []',
      () async {
        // assert
        expect(
          tLoadingState.props,
          [],
        );
      },
    );
  });

  group('WatchlistTvLoadedState', () {
    final tLoadedState = WatchlistTvLoadedState(tvList: [testTv]);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadedState.props, [tLoadedState.tvList]);
      },
    );
  });

  group('WatchlistTvFailureState', () {
    final tFailureState =
        WatchlistTvFailureState(errorMessage: 'tErrorMessage');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tFailureState.props, [tFailureState.errorMessage]);
      },
    );
  });
}
