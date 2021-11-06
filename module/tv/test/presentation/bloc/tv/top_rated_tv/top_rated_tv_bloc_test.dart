import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/tv/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late TopRatedTvBloc topRatedTvBloc;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    topRatedTvBloc = TopRatedTvBloc(
      getTopRatedTvs: mockGetTopRatedTvs,
    );
  });

  tearDown(() {
    topRatedTvBloc.close();
  });

  test(
    'pastikan iniitialState adalah TopRatedTvInitial',
    () async {
      // assert
      expect(
        topRatedTvBloc.state,
        TopRatedTvInitial(),
      );
    },
  );

  group('Load Data', () {
    final tTopRatedTvResponse = [testTv];

    blocTest(
      'emit [TopRatedTvLoadingState, TopRatedTvLoadedState]'
      'on LoadTopRatedTvEvent successfully',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(tTopRatedTvResponse));
        return topRatedTvBloc;
      },
      act: (TopRatedTvBloc bloc) => bloc.add(LoadTopRatedTvEvent()),
      expect: () => [
        TopRatedTvLoadingState(),
        TopRatedTvLoadedState(tvList: tTopRatedTvResponse),
      ],
    );

    blocTest(
      'emit [TopRatedTvLoadingState, TopRatedTvFailureState] '
      'on LoadTopRatedTvEvent with ServerFailure',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return topRatedTvBloc;
      },
      act: (TopRatedTvBloc bloc) => bloc.add(LoadTopRatedTvEvent()),
      expect: () => [
        TopRatedTvLoadingState(),
        TopRatedTvFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [TopRatedTvLoadingState, TopRatedTvFailureState] '
      'on LoadTopRatedTvEvent with ConnectionFailure',
      build: () {
        when(mockGetTopRatedTvs.execute()).thenAnswer(
            (_) async => Left(ConnectionFailure('testErrorMessage')));
        return topRatedTvBloc;
      },
      act: (TopRatedTvBloc bloc) {
        return bloc.add(LoadTopRatedTvEvent());
      },
      expect: () => [
        TopRatedTvLoadingState(),
        TopRatedTvFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [TopRatedTvLoadingState, TopRatedTvFailureState] '
      'on LoadTopRatedTvEvent with ConnectionFailure',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('testErrorMessage')));
        return topRatedTvBloc;
      },
      act: (TopRatedTvBloc bloc) {
        return bloc.add(LoadTopRatedTvEvent());
      },
      expect: () => [
        TopRatedTvLoadingState(),
        TopRatedTvFailureState(errorMessage: 'testErrorMessage'),
      ],
    );
  });
}
