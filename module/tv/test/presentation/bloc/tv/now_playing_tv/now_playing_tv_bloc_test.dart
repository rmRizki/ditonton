import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/tv/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetOnTheAirTvs mockGetOnTheAirTvs;
  late NowPlayingTvBloc nowPlayingTvBloc;

  setUp(() {
    mockGetOnTheAirTvs = MockGetOnTheAirTvs();
    nowPlayingTvBloc = NowPlayingTvBloc(
      getOnTheAirTvs: mockGetOnTheAirTvs,
    );
  });

  tearDown(() {
    nowPlayingTvBloc.close();
  });

  test(
    'pastikan iniitialState adalah NowPlayingTvInitial',
    () async {
      // assert
      expect(
        nowPlayingTvBloc.state,
        NowPlayingTvInitial(),
      );
    },
  );

  group('Load Data', () {
    final tNowPlayingTvResponse = [testTv];

    blocTest(
      'emit [NowPlayingTvLoadingState, NowPlayingTvLoadedState]'
      'on LoadNowPlayingTvEvent successfully',
      build: () {
        when(mockGetOnTheAirTvs.execute())
            .thenAnswer((_) async => Right(tNowPlayingTvResponse));
        return nowPlayingTvBloc;
      },
      act: (NowPlayingTvBloc bloc) => bloc.add(LoadNowPlayingTvEvent()),
      expect: () => [
        NowPlayingTvLoadingState(),
        NowPlayingTvLoadedState(tvList: tNowPlayingTvResponse),
      ],
    );

    blocTest(
      'emit [NowPlayingTvLoadingState, NowPlayingTvFailureState] '
      'on LoadNowPlayingTvEvent with ServerFailure',
      build: () {
        when(mockGetOnTheAirTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return nowPlayingTvBloc;
      },
      act: (NowPlayingTvBloc bloc) => bloc.add(LoadNowPlayingTvEvent()),
      expect: () => [
        NowPlayingTvLoadingState(),
        NowPlayingTvFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [NowPlayingTvLoadingState, NowPlayingTvFailureState] '
      'on LoadNowPlayingTvEvent with ConnectionFailure',
      build: () {
        when(mockGetOnTheAirTvs.execute()).thenAnswer(
            (_) async => Left(ConnectionFailure('testErrorMessage')));
        return nowPlayingTvBloc;
      },
      act: (NowPlayingTvBloc bloc) {
        return bloc.add(LoadNowPlayingTvEvent());
      },
      expect: () => [
        NowPlayingTvLoadingState(),
        NowPlayingTvFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [NowPlayingTvLoadingState, NowPlayingTvFailureState] '
      'on LoadNowPlayingTvEvent with ConnectionFailure',
      build: () {
        when(mockGetOnTheAirTvs.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('testErrorMessage')));
        return nowPlayingTvBloc;
      },
      act: (NowPlayingTvBloc bloc) {
        return bloc.add(LoadNowPlayingTvEvent());
      },
      expect: () => [
        NowPlayingTvLoadingState(),
        NowPlayingTvFailureState(errorMessage: 'testErrorMessage'),
      ],
    );
  });
}
