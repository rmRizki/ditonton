import 'package:movie/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('WatchlistMovieInitial', () {
    final tInitial = WatchlistMovieInitial();

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

  group('WatchlistMovieLoadingState', () {
    final tLoadingState = WatchlistMovieLoadingState();

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

  group('WatchlistMovieLoadedState', () {
    final tLoadedState = WatchlistMovieLoadedState(movieList: [testMovie]);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadedState.props, [tLoadedState.movieList]);
      },
    );
  });

  group('WatchlistMovieFailureState', () {
    final tFailureState =
        WatchlistMovieFailureState(errorMessage: 'tErrorMessage');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tFailureState.props, [tFailureState.errorMessage]);
      },
    );
  });
}
