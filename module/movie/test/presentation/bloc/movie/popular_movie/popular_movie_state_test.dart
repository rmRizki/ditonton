import 'package:movie/presentation/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('PopularMovieInitial', () {
    final tInitial = PopularMovieInitial();

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

  group('PopularMovieLoadingState', () {
    final tLoadingState = PopularMovieLoadingState();

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

  group('PopularMovieLoadedState', () {
    final tLoadedState = PopularMovieLoadedState(movieList: [testMovie]);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadedState.props, [tLoadedState.movieList]);
      },
    );
  });

  group('PopularMovieFailureState', () {
    final tFailureState =
        PopularMovieFailureState(errorMessage: 'tErrorMessage');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tFailureState.props, [tFailureState.errorMessage]);
      },
    );
  });
}
