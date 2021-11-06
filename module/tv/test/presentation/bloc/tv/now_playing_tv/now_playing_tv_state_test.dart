import 'package:tv/presentation/bloc/tv/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('NowPlayingTvInitial', () {
    final tInitial = NowPlayingTvInitial();

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

  group('NowPlayingTvLoadingState', () {
    final tLoadingState = NowPlayingTvLoadingState();

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

  group('NowPlayingTvLoadedState', () {
    final tLoadedState = NowPlayingTvLoadedState(tvList: [testTv]);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadedState.props, [tLoadedState.tvList]);
      },
    );
  });

  group('NowPlayingTvFailureState', () {
    final tFailureState =
        NowPlayingTvFailureState(errorMessage: 'tErrorMessage');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tFailureState.props, [tFailureState.errorMessage]);
      },
    );
  });
}
