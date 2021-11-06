import 'package:movie/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('MovieDetailInitial', () {
    final tInitial = MovieDetailInitial();

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

  group('MovieDetailLoadingState', () {
    final tLoadingState = MovieDetailLoadingState();

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

  group('MovieDetailLoadedState', () {
    final tLoadedState = MovieDetailLoadedState(
      movieDetail: testMovieDetail,
      isAddedToWatchlist: false,
      recommendationList: [testMovie],
      watchlistMessage: 'testMessage',
    );

    test(
      'make sure props value',
      () async {
        // assert
        expect(
          tLoadedState.props,
          [
            tLoadedState.movieDetail,
            tLoadedState.recommendationList,
            tLoadedState.isAddedToWatchlist,
            tLoadedState.watchlistMessage,
          ],
        );
      },
    );
  });

  group('MovieDetailFailureState', () {
    final tFailureState =
        MovieDetailFailureState(errorMessage: 'tErrorMessage');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tFailureState.props, [tFailureState.errorMessage]);
      },
    );
  });
}
