import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetPopularTvs mockGetPopularTvs;
  late PopularTvBloc topRatedTvBloc;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    topRatedTvBloc = PopularTvBloc(
      getPopularTvs: mockGetPopularTvs,
    );
  });

  tearDown(() {
    topRatedTvBloc.close();
  });

  test(
    'pastikan iniitialState adalah PopularTvInitial',
    () async {
      // assert
      expect(
        topRatedTvBloc.state,
        PopularTvInitial(),
      );
    },
  );

  group('Load Data', () {
    final tPopularTvResponse = [testTv];

    blocTest(
      'emit [PopularTvLoadingState, PopularTvLoadedState]'
      'on LoadPopularTvEvent successfully',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(tPopularTvResponse));
        return topRatedTvBloc;
      },
      act: (PopularTvBloc bloc) => bloc.add(LoadPopularTvEvent()),
      expect: () => [
        PopularTvLoadingState(),
        PopularTvLoadedState(tvList: tPopularTvResponse),
      ],
    );

    blocTest(
      'emit [PopularTvLoadingState, PopularTvFailureState] '
      'on LoadPopularTvEvent with ServerFailure',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return topRatedTvBloc;
      },
      act: (PopularTvBloc bloc) => bloc.add(LoadPopularTvEvent()),
      expect: () => [
        PopularTvLoadingState(),
        PopularTvFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [PopularTvLoadingState, PopularTvFailureState] '
      'on LoadPopularTvEvent with ConnectionFailure',
      build: () {
        when(mockGetPopularTvs.execute()).thenAnswer(
            (_) async => Left(ConnectionFailure('testErrorMessage')));
        return topRatedTvBloc;
      },
      act: (PopularTvBloc bloc) {
        return bloc.add(LoadPopularTvEvent());
      },
      expect: () => [
        PopularTvLoadingState(),
        PopularTvFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [PopularTvLoadingState, PopularTvFailureState] '
      'on LoadPopularTvEvent with ConnectionFailure',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('testErrorMessage')));
        return topRatedTvBloc;
      },
      act: (PopularTvBloc bloc) {
        return bloc.add(LoadPopularTvEvent());
      },
      expect: () => [
        PopularTvLoadingState(),
        PopularTvFailureState(errorMessage: 'testErrorMessage'),
      ],
    );
  });
}
