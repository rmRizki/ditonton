import 'package:tv/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('TvDetailInitial', () {
    final tInitial = TvDetailInitial();

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

  group('TvDetailLoadingState', () {
    final tLoadingState = TvDetailLoadingState();

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

  group('TvDetailLoadedState', () {
    final tLoadedState = TvDetailLoadedState(
      tvDetail: testTvDetail,
      isAddedToWatchlist: false,
      recommendationList: [testTv],
      watchlistMessage: 'testMessage',
    );

    test(
      'make sure props value',
      () async {
        // assert
        expect(
          tLoadedState.props,
          [
            tLoadedState.tvDetail,
            tLoadedState.recommendationList,
            tLoadedState.isAddedToWatchlist,
            tLoadedState.watchlistMessage,
          ],
        );
      },
    );
  });

  group('TvDetailFailureState', () {
    final tFailureState = TvDetailFailureState(errorMessage: 'tErrorMessage');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tFailureState.props, [tFailureState.errorMessage]);
      },
    );
  });
}
