import 'package:tv/presentation/bloc/tv/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('TopRatedTvInitial', () {
    final tInitial = TopRatedTvInitial();

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

  group('TopRatedTvLoadingState', () {
    final tLoadingState = TopRatedTvLoadingState();

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

  group('TopRatedTvLoadedState', () {
    final tLoadedState = TopRatedTvLoadedState(tvList: [testTv]);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadedState.props, [tLoadedState.tvList]);
      },
    );
  });

  group('TopRatedTvFailureState', () {
    final tFailureState = TopRatedTvFailureState(errorMessage: 'tErrorMessage');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tFailureState.props, [tFailureState.errorMessage]);
      },
    );
  });
}
