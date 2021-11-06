import 'package:movie/presentation/bloc/movie/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadTopRatedMovieEvent', () {
    final tLoadTopRatedMovieEvent = LoadTopRatedMovieEvent();

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadTopRatedMovieEvent.props, []);
      },
    );
  });
}
