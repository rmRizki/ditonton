import 'package:movie/presentation/bloc/movie/movie_search/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadMovieSearchEvent', () {
    final tLoadMovieSearchEvent = LoadMovieSearchEvent(query: '');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadMovieSearchEvent.props, [tLoadMovieSearchEvent.query]);
      },
    );
  });
}
