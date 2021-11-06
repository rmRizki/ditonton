import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlist;
  late TvDetailBloc tvDetailBloc;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();
    tvDetailBloc = TvDetailBloc(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListStatus: mockGetWatchListStatusTv,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  tearDown(() {
    tvDetailBloc.close();
  });

  test(
    'pastikan iniitialState adalah TvDetailInitial',
    () async {
      // assert
      expect(
        tvDetailBloc.state,
        TvDetailInitial(),
      );
    },
  );

  group('Load Data', () {
    final tTvDetailResponse = testTvDetail;
    final tTvRecommendationResponse = [testTv];
    final tIsAddedToWatchlist = true;

    final tEvent = LoadTvDetailEvent(id: 0);

    blocTest(
      'emit [TvDetailLoadingState, TvDetailLoadedState, TvDetailLoadedState]'
      'on LoadTvDetailEvent successfully',
      build: () {
        when(mockGetTvDetail.execute(tEvent.id))
            .thenAnswer((_) async => Right(tTvDetailResponse));
        when(mockGetTvRecommendations.execute(tEvent.id))
            .thenAnswer((_) async => Right(tTvRecommendationResponse));
        when(mockGetWatchListStatusTv.execute(tEvent.id))
            .thenAnswer((_) async => tIsAddedToWatchlist);
        return tvDetailBloc;
      },
      act: (TvDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        TvDetailLoadingState(),
        TvDetailLoadedState(
          tvDetail: tTvDetailResponse,
          isAddedToWatchlist: tIsAddedToWatchlist,
        ),
        TvDetailLoadedState(
          tvDetail: tTvDetailResponse,
          recommendationList: tTvRecommendationResponse,
          isAddedToWatchlist: tIsAddedToWatchlist,
        ),
      ],
    );

    blocTest(
      'emit [TvDetailLoadingState, TvDetailFailureState] '
      'on LoadTvDetailEvent with ServerFailure',
      build: () {
        when(mockGetTvDetail.execute(tEvent.id))
            .thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        when(mockGetTvRecommendations.execute(tEvent.id))
            .thenAnswer((_) async => Right(tTvRecommendationResponse));
        when(mockGetWatchListStatusTv.execute(tEvent.id))
            .thenAnswer((_) async => tIsAddedToWatchlist);
        return tvDetailBloc;
      },
      act: (TvDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        TvDetailLoadingState(),
        TvDetailFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [TvDetailLoadingState, TvDetailFailureState] '
      'on LoadTvDetailEvent with ConnectionFailure',
      build: () {
        when(mockGetTvDetail.execute(tEvent.id)).thenAnswer(
            (_) async => Left(ConnectionFailure('testErrorMessage')));
        when(mockGetTvRecommendations.execute(tEvent.id))
            .thenAnswer((_) async => Right(tTvRecommendationResponse));
        when(mockGetWatchListStatusTv.execute(tEvent.id))
            .thenAnswer((_) async => tIsAddedToWatchlist);
        return tvDetailBloc;
      },
      act: (TvDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        TvDetailLoadingState(),
        TvDetailFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [TvDetailLoadingState, TvDetailFailureState] '
      'on LoadTvDetailEvent with ConnectionFailure',
      build: () {
        when(mockGetTvDetail.execute(tEvent.id))
            .thenAnswer((_) async => Left(DatabaseFailure('testErrorMessage')));
        when(mockGetTvRecommendations.execute(tEvent.id))
            .thenAnswer((_) async => Right(tTvRecommendationResponse));
        when(mockGetWatchListStatusTv.execute(tEvent.id))
            .thenAnswer((_) async => tIsAddedToWatchlist);
        return tvDetailBloc;
      },
      act: (TvDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        TvDetailLoadingState(),
        TvDetailFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [TvDetailLoadingState, TvDetailLoadedState] '
      'on LoadTvDetailEvent with Recommendation Failure',
      build: () {
        when(mockGetTvDetail.execute(tEvent.id))
            .thenAnswer((_) async => Right(tTvDetailResponse));
        when(mockGetTvRecommendations.execute(tEvent.id)).thenAnswer(
            (_) async => Left(ConnectionFailure('testErrorMessage')));
        when(mockGetWatchListStatusTv.execute(tEvent.id))
            .thenAnswer((_) async => tIsAddedToWatchlist);
        return tvDetailBloc;
      },
      act: (TvDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        TvDetailLoadingState(),
        TvDetailLoadedState(
          tvDetail: tTvDetailResponse,
          isAddedToWatchlist: tIsAddedToWatchlist,
        ),
        TvDetailLoadedState(
          tvDetail: tTvDetailResponse,
          recommendationList: [],
          isAddedToWatchlist: tIsAddedToWatchlist,
        ),
      ],
    );
  });

  group('Add Watchlist', () {
    final tTvDetailResponse = testTvDetail;
    final tIsAddedToWatchlist = true;
    final tWatchlistMessage = 'tWatchlistMessage';

    final tEvent = AddWatchlistEvent(tvDetail: tTvDetailResponse);

    blocTest(
      'emit [TvDetailLoadedState]'
      'on AddWatchlistEvent successfully',
      build: () {
        when(mockSaveWatchlist.execute(tTvDetailResponse))
            .thenAnswer((_) async => Right(tWatchlistMessage));
        when(mockGetWatchListStatusTv.execute(tTvDetailResponse.id))
            .thenAnswer((_) async => tIsAddedToWatchlist);
        return tvDetailBloc;
      },
      act: (TvDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        TvDetailLoadedState(
          tvDetail: null,
          recommendationList: [],
          isAddedToWatchlist: tIsAddedToWatchlist,
          watchlistMessage: tWatchlistMessage,
        ),
      ],
    );

    blocTest(
      'emit [TvDetailLoadedState]'
      'on AddWatchlistEvent with DatabaseFailure',
      build: () {
        when(mockSaveWatchlist.execute(tTvDetailResponse))
            .thenAnswer((_) async => Left(DatabaseFailure(tWatchlistMessage)));
        when(mockGetWatchListStatusTv.execute(tTvDetailResponse.id))
            .thenAnswer((_) async => !tIsAddedToWatchlist);
        return tvDetailBloc;
      },
      act: (TvDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        TvDetailLoadedState(
          tvDetail: null,
          recommendationList: [],
          isAddedToWatchlist: !tIsAddedToWatchlist,
          watchlistMessage: tWatchlistMessage,
        ),
      ],
    );
  });

  group('Remove Watchlist', () {
    final tTvDetailResponse = testTvDetail;
    final tIsAddedToWatchlist = true;
    final tWatchlistMessage = 'tWatchlistMessage';

    final tEvent = RemoveWatchlistEvent(tvDetail: tTvDetailResponse);

    blocTest(
      'emit [TvDetailLoadedState]'
      'on RemoveWatchlistEvent successfully',
      build: () {
        when(mockRemoveWatchlist.execute(tTvDetailResponse))
            .thenAnswer((_) async => Right(tWatchlistMessage));
        when(mockGetWatchListStatusTv.execute(tTvDetailResponse.id))
            .thenAnswer((_) async => !tIsAddedToWatchlist);
        return tvDetailBloc;
      },
      act: (TvDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        TvDetailLoadedState(
          tvDetail: null,
          recommendationList: [],
          isAddedToWatchlist: !tIsAddedToWatchlist,
          watchlistMessage: tWatchlistMessage,
        ),
      ],
    );

    blocTest(
      'emit [TvDetailLoadedState]'
      'on RemoveWatchlistEvent with DatabaseFailure',
      build: () {
        when(mockRemoveWatchlist.execute(tTvDetailResponse))
            .thenAnswer((_) async => Left(DatabaseFailure(tWatchlistMessage)));
        when(mockGetWatchListStatusTv.execute(tTvDetailResponse.id))
            .thenAnswer((_) async => tIsAddedToWatchlist);
        return tvDetailBloc;
      },
      act: (TvDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        TvDetailLoadedState(
          tvDetail: null,
          recommendationList: [],
          isAddedToWatchlist: tIsAddedToWatchlist,
          watchlistMessage: tWatchlistMessage,
        ),
      ],
    );
  });
}
