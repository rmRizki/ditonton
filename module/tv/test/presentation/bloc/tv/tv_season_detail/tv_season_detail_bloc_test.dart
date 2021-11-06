import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/tv/tv_season_detail/tv_season_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetTvSeasonDetail mockGetTvSeasonDetail;
  late TvSeasonDetailBloc tvSeasonDetailBloc;

  setUp(() {
    mockGetTvSeasonDetail = MockGetTvSeasonDetail();
    tvSeasonDetailBloc = TvSeasonDetailBloc(
      getTvSeasonDetail: mockGetTvSeasonDetail,
    );
  });

  tearDown(() {
    tvSeasonDetailBloc.close();
  });

  test(
    'pastikan iniitialState adalah TvSeasonDetailInitial',
    () async {
      // assert
      expect(
        tvSeasonDetailBloc.state,
        TvSeasonDetailInitial(),
      );
    },
  );

  group('Load Data', () {
    final tTvSeasonDetailResponse = testSeasonDetail;

    final tEvent = LoadTvSeasonDetailEvent(id: 0, seasonNumber: 0);

    blocTest(
      'emit [TvSeasonDetailLoadingState, TvSeasonDetailLoadedState]'
      'on LoadTvSeasonDetailEvent successfully',
      build: () {
        when(mockGetTvSeasonDetail.execute(tEvent.id, tEvent.seasonNumber))
            .thenAnswer((_) async => Right(tTvSeasonDetailResponse));
        return tvSeasonDetailBloc;
      },
      act: (TvSeasonDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        TvSeasonDetailLoadingState(),
        TvSeasonDetailLoadedState(seasonDetail: tTvSeasonDetailResponse),
      ],
    );

    blocTest(
      'emit [TvSeasonDetailLoadingState, TvSeasonDetailFailureState] '
      'on LoadTvSeasonDetailEvent with ServerFailure',
      build: () {
        when(mockGetTvSeasonDetail.execute(tEvent.id, tEvent.seasonNumber))
            .thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return tvSeasonDetailBloc;
      },
      act: (TvSeasonDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        TvSeasonDetailLoadingState(),
        TvSeasonDetailFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [TvSeasonDetailLoadingState, TvSeasonDetailFailureState] '
      'on LoadTvSeasonDetailEvent with ConnectionFailure',
      build: () {
        when(mockGetTvSeasonDetail.execute(tEvent.id, tEvent.seasonNumber))
            .thenAnswer(
                (_) async => Left(ConnectionFailure('testErrorMessage')));
        return tvSeasonDetailBloc;
      },
      act: (TvSeasonDetailBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        TvSeasonDetailLoadingState(),
        TvSeasonDetailFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [TvSeasonDetailLoadingState, TvSeasonDetailFailureState] '
      'on LoadTvSeasonDetailEvent with ConnectionFailure',
      build: () {
        when(mockGetTvSeasonDetail.execute(tEvent.id, tEvent.seasonNumber))
            .thenAnswer((_) async => Left(DatabaseFailure('testErrorMessage')));
        return tvSeasonDetailBloc;
      },
      act: (TvSeasonDetailBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        TvSeasonDetailLoadingState(),
        TvSeasonDetailFailureState(errorMessage: 'testErrorMessage'),
      ],
    );
  });
}
