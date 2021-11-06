import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/presentation/bloc/movie/movie_search/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockSearchMovies mockSearchMovies;
  late MovieSearchBloc movieSearchBloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(
      searchMovies: mockSearchMovies,
    );
  });

  tearDown(() {
    movieSearchBloc.close();
  });

  test(
    'pastikan iniitialState adalah MovieSearchInitial',
    () async {
      // assert
      expect(
        movieSearchBloc.state,
        MovieSearchInitial(),
      );
    },
  );

  group('Load Data', () {
    final tMovieSearchResponse = [testMovie];

    final tEvent = LoadMovieSearchEvent(query: '');

    blocTest(
      'emit [MovieSearchLoadingState, MovieSearchLoadedState]'
      'on LoadMovieSearchEvent successfully',
      build: () {
        when(mockSearchMovies.execute(tEvent.query))
            .thenAnswer((_) async => Right(tMovieSearchResponse));
        return movieSearchBloc;
      },
      act: (MovieSearchBloc bloc) => bloc.add(tEvent),
      wait: Duration(milliseconds: 500),
      expect: () => [
        MovieSearchLoadingState(),
        MovieSearchLoadedState(movieList: tMovieSearchResponse),
      ],
    );

    blocTest(
      'emit [MovieSearchLoadingState, MovieSearchFailureState] '
      'on LoadMovieSearchEvent with ServerFailure',
      build: () {
        when(mockSearchMovies.execute(tEvent.query))
            .thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return movieSearchBloc;
      },
      act: (MovieSearchBloc bloc) => bloc.add(tEvent),
      wait: Duration(milliseconds: 500),
      expect: () => [
        MovieSearchLoadingState(),
        MovieSearchFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [MovieSearchLoadingState, MovieSearchFailureState] '
      'on LoadMovieSearchEvent with ConnectionFailure',
      build: () {
        when(mockSearchMovies.execute(tEvent.query)).thenAnswer(
            (_) async => Left(ConnectionFailure('testErrorMessage')));
        return movieSearchBloc;
      },
      act: (MovieSearchBloc bloc) => bloc.add(tEvent),
      wait: Duration(milliseconds: 500),
      expect: () => [
        MovieSearchLoadingState(),
        MovieSearchFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [MovieSearchLoadingState, MovieSearchFailureState] '
      'on LoadMovieSearchEvent with ConnectionFailure',
      build: () {
        when(mockSearchMovies.execute(tEvent.query))
            .thenAnswer((_) async => Left(DatabaseFailure('testErrorMessage')));
        return movieSearchBloc;
      },
      act: (MovieSearchBloc bloc) => bloc.add(tEvent),
      wait: Duration(milliseconds: 500),
      expect: () => [
        MovieSearchLoadingState(),
        MovieSearchFailureState(errorMessage: 'testErrorMessage'),
      ],
    );
  });
}
