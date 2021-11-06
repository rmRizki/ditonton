import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late WatchlistMovieBloc watchlistMovieBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  tearDown(() {
    watchlistMovieBloc.close();
  });

  test(
    'pastikan iniitialState adalah WatchlistMovieInitial',
    () async {
      // assert
      expect(
        watchlistMovieBloc.state,
        WatchlistMovieInitial(),
      );
    },
  );

  group('Load Data', () {
    final tWatchlistMovieResponse = [testMovie];

    blocTest(
      'emit [WatchlistMovieLoadingState, WatchlistMovieLoadedState]'
      'on LoadWatchlistMovieEvent successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tWatchlistMovieResponse));
        return watchlistMovieBloc;
      },
      act: (WatchlistMovieBloc bloc) => bloc.add(LoadWatchlistMovieEvent()),
      expect: () => [
        WatchlistMovieLoadingState(),
        WatchlistMovieLoadedState(movieList: tWatchlistMovieResponse),
      ],
    );

    blocTest(
      'emit [WatchlistMovieLoadingState, WatchlistMovieFailureState] '
      'on LoadWatchlistMovieEvent with ServerFailure',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return watchlistMovieBloc;
      },
      act: (WatchlistMovieBloc bloc) => bloc.add(LoadWatchlistMovieEvent()),
      expect: () => [
        WatchlistMovieLoadingState(),
        WatchlistMovieFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [WatchlistMovieLoadingState, WatchlistMovieFailureState] '
      'on LoadWatchlistMovieEvent with ConnectionFailure',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => Left(ConnectionFailure('testErrorMessage')));
        return watchlistMovieBloc;
      },
      act: (WatchlistMovieBloc bloc) {
        return bloc.add(LoadWatchlistMovieEvent());
      },
      expect: () => [
        WatchlistMovieLoadingState(),
        WatchlistMovieFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [WatchlistMovieLoadingState, WatchlistMovieFailureState] '
      'on LoadWatchlistMovieEvent with ConnectionFailure',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('testErrorMessage')));
        return watchlistMovieBloc;
      },
      act: (WatchlistMovieBloc bloc) {
        return bloc.add(LoadWatchlistMovieEvent());
      },
      expect: () => [
        WatchlistMovieLoadingState(),
        WatchlistMovieFailureState(errorMessage: 'testErrorMessage'),
      ],
    );
  });
}
