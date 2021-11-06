import 'package:movie/presentation/bloc/movie/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('NowPlayingMovieInitial', () {
    final tInitial = NowPlayingMovieInitial();

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

  group('NowPlayingMovieLoadingState', () {
    final tLoadingState = NowPlayingMovieLoadingState();

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

  group('NowPlayingMovieLoadedState', () {
    final tLoadedState = NowPlayingMovieLoadedState(movieList: [testMovie]);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadedState.props, [tLoadedState.movieList]);
      },
    );
  });

  group('NowPlayingMovieFailureState', () {
    final tFailureState =
        NowPlayingMovieFailureState(errorMessage: 'tErrorMessage');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tFailureState.props, [tFailureState.errorMessage]);
      },
    );
  });
}
