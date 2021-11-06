import 'package:movie/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadWatchlistMovieEvent', () {
    final tLoadWatchlistMovieEvent = LoadWatchlistMovieEvent();

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadWatchlistMovieEvent.props, []);
      },
    );
  });
}
