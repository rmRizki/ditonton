import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetWatchlistTvs mockGetWatchlistTvs;
  late WatchlistTvBloc watchlistTvBloc;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    watchlistTvBloc = WatchlistTvBloc(
      getWatchlistTvs: mockGetWatchlistTvs,
    );
  });

  tearDown(() {
    watchlistTvBloc.close();
  });

  test(
    'pastikan iniitialState adalah WatchlistTvInitial',
    () async {
      // assert
      expect(
        watchlistTvBloc.state,
        WatchlistTvInitial(),
      );
    },
  );

  group('Load Data', () {
    final tWatchlistTvResponse = [testTv];

    blocTest(
      'emit [WatchlistTvLoadingState, WatchlistTvLoadedState]'
      'on LoadWatchlistTvEvent successfully',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Right(tWatchlistTvResponse));
        return watchlistTvBloc;
      },
      act: (WatchlistTvBloc bloc) => bloc.add(LoadWatchlistTvEvent()),
      expect: () => [
        WatchlistTvLoadingState(),
        WatchlistTvLoadedState(tvList: tWatchlistTvResponse),
      ],
    );

    blocTest(
      'emit [WatchlistTvLoadingState, WatchlistTvFailureState] '
      'on LoadWatchlistTvEvent with ServerFailure',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return watchlistTvBloc;
      },
      act: (WatchlistTvBloc bloc) => bloc.add(LoadWatchlistTvEvent()),
      expect: () => [
        WatchlistTvLoadingState(),
        WatchlistTvFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [WatchlistTvLoadingState, WatchlistTvFailureState] '
      'on LoadWatchlistTvEvent with ConnectionFailure',
      build: () {
        when(mockGetWatchlistTvs.execute()).thenAnswer(
            (_) async => Left(ConnectionFailure('testErrorMessage')));
        return watchlistTvBloc;
      },
      act: (WatchlistTvBloc bloc) {
        return bloc.add(LoadWatchlistTvEvent());
      },
      expect: () => [
        WatchlistTvLoadingState(),
        WatchlistTvFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [WatchlistTvLoadingState, WatchlistTvFailureState] '
      'on LoadWatchlistTvEvent with ConnectionFailure',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('testErrorMessage')));
        return watchlistTvBloc;
      },
      act: (WatchlistTvBloc bloc) {
        return bloc.add(LoadWatchlistTvEvent());
      },
      expect: () => [
        WatchlistTvLoadingState(),
        WatchlistTvFailureState(errorMessage: 'testErrorMessage'),
      ],
    );
  });
}
