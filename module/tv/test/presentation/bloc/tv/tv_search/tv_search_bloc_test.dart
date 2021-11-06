import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/tv/tv_search/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockSearchTvs mockSearchTvs;
  late TvSearchBloc tvSearchBloc;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    tvSearchBloc = TvSearchBloc(
      searchTvs: mockSearchTvs,
    );
  });

  tearDown(() {
    tvSearchBloc.close();
  });

  test(
    'pastikan iniitialState adalah TvSearchInitial',
    () async {
      // assert
      expect(
        tvSearchBloc.state,
        TvSearchInitial(),
      );
    },
  );

  group('Load Data', () {
    final tTvSearchResponse = [testTv];

    final tEvent = LoadTvSearchEvent(query: '');

    blocTest(
      'emit [TvSearchLoadingState, TvSearchLoadedState]'
      'on LoadTvSearchEvent successfully',
      build: () {
        when(mockSearchTvs.execute(tEvent.query))
            .thenAnswer((_) async => Right(tTvSearchResponse));
        return tvSearchBloc;
      },
      act: (TvSearchBloc bloc) => bloc.add(tEvent),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvSearchLoadingState(),
        TvSearchLoadedState(tvList: tTvSearchResponse),
      ],
    );

    blocTest(
      'emit [TvSearchLoadingState, TvSearchFailureState] '
      'on LoadTvSearchEvent with ServerFailure',
      build: () {
        when(mockSearchTvs.execute(tEvent.query))
            .thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return tvSearchBloc;
      },
      act: (TvSearchBloc bloc) => bloc.add(tEvent),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvSearchLoadingState(),
        TvSearchFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [TvSearchLoadingState, TvSearchFailureState] '
      'on LoadTvSearchEvent with ConnectionFailure',
      build: () {
        when(mockSearchTvs.execute(tEvent.query)).thenAnswer(
            (_) async => Left(ConnectionFailure('testErrorMessage')));
        return tvSearchBloc;
      },
      act: (TvSearchBloc bloc) => bloc.add(tEvent),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvSearchLoadingState(),
        TvSearchFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [TvSearchLoadingState, TvSearchFailureState] '
      'on LoadTvSearchEvent with ConnectionFailure',
      build: () {
        when(mockSearchTvs.execute(tEvent.query))
            .thenAnswer((_) async => Left(DatabaseFailure('testErrorMessage')));
        return tvSearchBloc;
      },
      act: (TvSearchBloc bloc) => bloc.add(tEvent),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvSearchLoadingState(),
        TvSearchFailureState(errorMessage: 'testErrorMessage'),
      ],
    );
  });
}
