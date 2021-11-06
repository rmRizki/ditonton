import 'package:tv/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('PopularTvInitial', () {
    final tInitial = PopularTvInitial();

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

  group('PopularTvLoadingState', () {
    final tLoadingState = PopularTvLoadingState();

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

  group('PopularTvLoadedState', () {
    final tLoadedState = PopularTvLoadedState(tvList: [testTv]);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadedState.props, [tLoadedState.tvList]);
      },
    );
  });

  group('PopularTvFailureState', () {
    final tFailureState = PopularTvFailureState(errorMessage: 'tErrorMessage');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tFailureState.props, [tFailureState.errorMessage]);
      },
    );
  });
}
