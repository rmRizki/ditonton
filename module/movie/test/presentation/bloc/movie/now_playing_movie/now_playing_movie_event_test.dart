import 'package:movie/presentation/bloc/movie/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadNowPlayingMovieEvent', () {
    final tLoadNowPlayingMovieEvent = LoadNowPlayingMovieEvent();

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadNowPlayingMovieEvent.props, []);
      },
    );
  });
}
