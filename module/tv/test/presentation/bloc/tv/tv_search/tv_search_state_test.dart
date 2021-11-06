import 'package:tv/presentation/bloc/tv/tv_search/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('TvSearchInitial', () {
    final tInitial = TvSearchInitial();

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

  group('TvSearchLoadingState', () {
    final tLoadingState = TvSearchLoadingState();

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

  group('TvSearchLoadedState', () {
    final tLoadedState = TvSearchLoadedState(tvList: [testTv]);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadedState.props, [tLoadedState.tvList]);
      },
    );
  });

  group('TvSearchFailureState', () {
    final tFailureState = TvSearchFailureState(errorMessage: 'tErrorMessage');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tFailureState.props, [tFailureState.errorMessage]);
      },
    );
  });
}
