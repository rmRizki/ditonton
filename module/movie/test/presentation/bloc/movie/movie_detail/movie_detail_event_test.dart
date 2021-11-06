import 'package:movie/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('LoadMovieDetailEvent', () {
    final tLoadMovieDetailEvent = LoadMovieDetailEvent(id: 0);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadMovieDetailEvent.props, [tLoadMovieDetailEvent.id]);
      },
    );
  });

  group('AddWatchlistEvent', () {
    final tAddWatchlistEvent = AddWatchlistEvent(movieDetail: testMovieDetail);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tAddWatchlistEvent.props, [tAddWatchlistEvent.movieDetail]);
      },
    );
  });

  group('RemoveWatchlistEvent', () {
    final tRemoveWatchlistEvent =
        RemoveWatchlistEvent(movieDetail: testMovieDetail);

    test(
      'make sure props value',
      () async {
        // assert
        expect(
            tRemoveWatchlistEvent.props, [tRemoveWatchlistEvent.movieDetail]);
      },
    );
  });
}
