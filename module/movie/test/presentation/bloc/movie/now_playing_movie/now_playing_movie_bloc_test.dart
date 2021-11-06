import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/presentation/bloc/movie/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMovieBloc nowPlayingMovieBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieBloc = NowPlayingMovieBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
    );
  });

  tearDown(() {
    nowPlayingMovieBloc.close();
  });

  test(
    'pastikan iniitialState adalah NowPlayingMovieInitial',
    () async {
      // assert
      expect(
        nowPlayingMovieBloc.state,
        NowPlayingMovieInitial(),
      );
    },
  );

  group('Load Data', () {
    final tNowPlayingMovieResponse = [testMovie];

    blocTest(
      'emit [NowPlayingMovieLoadingState, NowPlayingMovieLoadedState]'
      'on LoadNowPlayingMovieEvent successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tNowPlayingMovieResponse));
        return nowPlayingMovieBloc;
      },
      act: (NowPlayingMovieBloc bloc) => bloc.add(LoadNowPlayingMovieEvent()),
      expect: () => [
        NowPlayingMovieLoadingState(),
        NowPlayingMovieLoadedState(movieList: tNowPlayingMovieResponse),
      ],
    );

    blocTest(
      'emit [NowPlayingMovieLoadingState, NowPlayingMovieFailureState] '
      'on LoadNowPlayingMovieEvent with ServerFailure',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return nowPlayingMovieBloc;
      },
      act: (NowPlayingMovieBloc bloc) => bloc.add(LoadNowPlayingMovieEvent()),
      expect: () => [
        NowPlayingMovieLoadingState(),
        NowPlayingMovieFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [NowPlayingMovieLoadingState, NowPlayingMovieFailureState] '
      'on LoadNowPlayingMovieEvent with ConnectionFailure',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => Left(ConnectionFailure('testErrorMessage')));
        return nowPlayingMovieBloc;
      },
      act: (NowPlayingMovieBloc bloc) {
        return bloc.add(LoadNowPlayingMovieEvent());
      },
      expect: () => [
        NowPlayingMovieLoadingState(),
        NowPlayingMovieFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [NowPlayingMovieLoadingState, NowPlayingMovieFailureState] '
      'on LoadNowPlayingMovieEvent with ConnectionFailure',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('testErrorMessage')));
        return nowPlayingMovieBloc;
      },
      act: (NowPlayingMovieBloc bloc) {
        return bloc.add(LoadNowPlayingMovieEvent());
      },
      expect: () => [
        NowPlayingMovieLoadingState(),
        NowPlayingMovieFailureState(errorMessage: 'testErrorMessage'),
      ],
    );
  });
}
