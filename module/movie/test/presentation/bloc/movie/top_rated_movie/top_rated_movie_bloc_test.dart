import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/presentation/bloc/movie/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMovieBloc topRatedMovieBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  tearDown(() {
    topRatedMovieBloc.close();
  });

  test(
    'pastikan iniitialState adalah TopRatedMovieInitial',
    () async {
      // assert
      expect(
        topRatedMovieBloc.state,
        TopRatedMovieInitial(),
      );
    },
  );

  group('Load Data', () {
    final tTopRatedMovieResponse = [testMovie];

    blocTest(
      'emit [TopRatedMovieLoadingState, TopRatedMovieLoadedState]'
      'on LoadTopRatedMovieEvent successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tTopRatedMovieResponse));
        return topRatedMovieBloc;
      },
      act: (TopRatedMovieBloc bloc) => bloc.add(LoadTopRatedMovieEvent()),
      expect: () => [
        TopRatedMovieLoadingState(),
        TopRatedMovieLoadedState(movieList: tTopRatedMovieResponse),
      ],
    );

    blocTest(
      'emit [TopRatedMovieLoadingState, TopRatedMovieFailureState] '
      'on LoadTopRatedMovieEvent with ServerFailure',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return topRatedMovieBloc;
      },
      act: (TopRatedMovieBloc bloc) => bloc.add(LoadTopRatedMovieEvent()),
      expect: () => [
        TopRatedMovieLoadingState(),
        TopRatedMovieFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [TopRatedMovieLoadingState, TopRatedMovieFailureState] '
      'on LoadTopRatedMovieEvent with ConnectionFailure',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => Left(ConnectionFailure('testErrorMessage')));
        return topRatedMovieBloc;
      },
      act: (TopRatedMovieBloc bloc) {
        return bloc.add(LoadTopRatedMovieEvent());
      },
      expect: () => [
        TopRatedMovieLoadingState(),
        TopRatedMovieFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [TopRatedMovieLoadingState, TopRatedMovieFailureState] '
      'on LoadTopRatedMovieEvent with ConnectionFailure',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('testErrorMessage')));
        return topRatedMovieBloc;
      },
      act: (TopRatedMovieBloc bloc) {
        return bloc.add(LoadTopRatedMovieEvent());
      },
      expect: () => [
        TopRatedMovieLoadingState(),
        TopRatedMovieFailureState(errorMessage: 'testErrorMessage'),
      ],
    );
  });
}
