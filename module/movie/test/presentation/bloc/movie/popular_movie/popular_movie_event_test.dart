import 'package:movie/presentation/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadPopularMovieEvent', () {
    final tLoadPopularMovieEvent = LoadPopularMovieEvent();

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadPopularMovieEvent.props, []);
      },
    );
  });
}
