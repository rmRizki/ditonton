import 'package:tv/presentation/bloc/tv/tv_season_detail/tv_season_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('TvSeasonDetailInitial', () {
    final tInitial = TvSeasonDetailInitial();

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

  group('TvSeasonDetailLoadingState', () {
    final tLoadingState = TvSeasonDetailLoadingState();

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

  group('TvSeasonDetailLoadedState', () {
    final tLoadedState =
        TvSeasonDetailLoadedState(seasonDetail: testSeasonDetail);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadedState.props, [tLoadedState.seasonDetail]);
      },
    );
  });

  group('TvSeasonDetailFailureState', () {
    final tFailureState =
        TvSeasonDetailFailureState(errorMessage: 'tErrorMessage');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tFailureState.props, [tFailureState.errorMessage]);
      },
    );
  });
}
