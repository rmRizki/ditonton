import 'package:movie/presentation/bloc/movie/movie_search/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('MovieSearchInitial', () {
    final tInitial = MovieSearchInitial();

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

  group('MovieSearchLoadingState', () {
    final tLoadingState = MovieSearchLoadingState();

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

  group('MovieSearchLoadedState', () {
    final tLoadedState = MovieSearchLoadedState(movieList: [testMovie]);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadedState.props, [tLoadedState.movieList]);
      },
    );
  });

  group('MovieSearchFailureState', () {
    final tFailureState =
        MovieSearchFailureState(errorMessage: 'tErrorMessage');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tFailureState.props, [tFailureState.errorMessage]);
      },
    );
  });
}
