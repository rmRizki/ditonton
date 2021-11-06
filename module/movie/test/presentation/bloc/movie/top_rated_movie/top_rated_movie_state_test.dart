import 'package:movie/presentation/bloc/movie/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('TopRatedMovieInitial', () {
    final tInitial = TopRatedMovieInitial();

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

  group('TopRatedMovieLoadingState', () {
    final tLoadingState = TopRatedMovieLoadingState();

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

  group('TopRatedMovieLoadedState', () {
    final tLoadedState = TopRatedMovieLoadedState(movieList: [testMovie]);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadedState.props, [tLoadedState.movieList]);
      },
    );
  });

  group('TopRatedMovieFailureState', () {
    final tFailureState =
        TopRatedMovieFailureState(errorMessage: 'tErrorMessage');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tFailureState.props, [tFailureState.errorMessage]);
      },
    );
  });
}
