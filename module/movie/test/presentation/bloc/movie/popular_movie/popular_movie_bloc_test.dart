import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/presentation/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMovieBloc topRatedMovieBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    topRatedMovieBloc = PopularMovieBloc(
      getPopularMovies: mockGetPopularMovies,
    );
  });

  tearDown(() {
    topRatedMovieBloc.close();
  });

  test(
    'pastikan iniitialState adalah PopularMovieInitial',
    () async {
      // assert
      expect(
        topRatedMovieBloc.state,
        PopularMovieInitial(),
      );
    },
  );

  group('Load Data', () {
    final tPopularMovieResponse = [testMovie];

    blocTest(
      'emit [PopularMovieLoadingState, PopularMovieLoadedState]'
      'on LoadPopularMovieEvent successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tPopularMovieResponse));
        return topRatedMovieBloc;
      },
      act: (PopularMovieBloc bloc) => bloc.add(LoadPopularMovieEvent()),
      expect: () => [
        PopularMovieLoadingState(),
        PopularMovieLoadedState(movieList: tPopularMovieResponse),
      ],
    );

    blocTest(
      'emit [PopularMovieLoadingState, PopularMovieFailureState] '
      'on LoadPopularMovieEvent with ServerFailure',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return topRatedMovieBloc;
      },
      act: (PopularMovieBloc bloc) => bloc.add(LoadPopularMovieEvent()),
      expect: () => [
        PopularMovieLoadingState(),
        PopularMovieFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [PopularMovieLoadingState, PopularMovieFailureState] '
      'on LoadPopularMovieEvent with ConnectionFailure',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => Left(ConnectionFailure('testErrorMessage')));
        return topRatedMovieBloc;
      },
      act: (PopularMovieBloc bloc) {
        return bloc.add(LoadPopularMovieEvent());
      },
      expect: () => [
        PopularMovieLoadingState(),
        PopularMovieFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [PopularMovieLoadingState, PopularMovieFailureState] '
      'on LoadPopularMovieEvent with ConnectionFailure',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('testErrorMessage')));
        return topRatedMovieBloc;
      },
      act: (PopularMovieBloc bloc) {
        return bloc.add(LoadPopularMovieEvent());
      },
      expect: () => [
        PopularMovieLoadingState(),
        PopularMovieFailureState(errorMessage: 'testErrorMessage'),
      ],
    );
  });
}
