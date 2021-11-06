import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatusMovie mockGetWatchListStatusMovie;
  late MockSaveWatchlistMovie mockSaveWatchlist;
  late MockRemoveWatchlistMovie mockRemoveWatchlist;
  late MovieDetailBloc movieDetailBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatusMovie = MockGetWatchListStatusMovie();
    mockSaveWatchlist = MockSaveWatchlistMovie();
    mockRemoveWatchlist = MockRemoveWatchlistMovie();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatusMovie,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  tearDown(() {
    movieDetailBloc.close();
  });

  test(
    'pastikan iniitialState adalah MovieDetailInitial',
    () async {
      // assert
      expect(
        movieDetailBloc.state,
        MovieDetailInitial(),
      );
    },
  );

  group('Load Data', () {
    final tMovieDetailResponse = testMovieDetail;
    final tMovieRecommendationResponse = [testMovie];
    final tIsAddedToWatchlist = true;

    final tEvent = LoadMovieDetailEvent(id: 0);

    blocTest(
      'emit [MovieDetailLoadingState, MovieDetailLoadedState, MovieDetailLoadedState]'
      'on LoadMovieDetailEvent successfully',
      build: () {
        when(mockGetMovieDetail.execute(tEvent.id))
            .thenAnswer((_) async => Right(tMovieDetailResponse));
        when(mockGetMovieRecommendations.execute(tEvent.id))
            .thenAnswer((_) async => Right(tMovieRecommendationResponse));
        when(mockGetWatchListStatusMovie.execute(tEvent.id))
            .thenAnswer((_) async => tIsAddedToWatchlist);
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        MovieDetailLoadingState(),
        MovieDetailLoadedState(
          movieDetail: tMovieDetailResponse,
          isAddedToWatchlist: tIsAddedToWatchlist,
        ),
        MovieDetailLoadedState(
          movieDetail: tMovieDetailResponse,
          recommendationList: tMovieRecommendationResponse,
          isAddedToWatchlist: tIsAddedToWatchlist,
        ),
      ],
    );

    blocTest(
      'emit [MovieDetailLoadingState, MovieDetailFailureState] '
      'on LoadMovieDetailEvent with ServerFailure',
      build: () {
        when(mockGetMovieDetail.execute(tEvent.id))
            .thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        when(mockGetMovieRecommendations.execute(tEvent.id))
            .thenAnswer((_) async => Right(tMovieRecommendationResponse));
        when(mockGetWatchListStatusMovie.execute(tEvent.id))
            .thenAnswer((_) async => tIsAddedToWatchlist);
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        MovieDetailLoadingState(),
        MovieDetailFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [MovieDetailLoadingState, MovieDetailFailureState] '
      'on LoadMovieDetailEvent with ConnectionFailure',
      build: () {
        when(mockGetMovieDetail.execute(tEvent.id)).thenAnswer(
            (_) async => Left(ConnectionFailure('testErrorMessage')));
        when(mockGetMovieRecommendations.execute(tEvent.id))
            .thenAnswer((_) async => Right(tMovieRecommendationResponse));
        when(mockGetWatchListStatusMovie.execute(tEvent.id))
            .thenAnswer((_) async => tIsAddedToWatchlist);
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        MovieDetailLoadingState(),
        MovieDetailFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [MovieDetailLoadingState, MovieDetailFailureState] '
      'on LoadMovieDetailEvent with ConnectionFailure',
      build: () {
        when(mockGetMovieDetail.execute(tEvent.id))
            .thenAnswer((_) async => Left(DatabaseFailure('testErrorMessage')));
        when(mockGetMovieRecommendations.execute(tEvent.id))
            .thenAnswer((_) async => Right(tMovieRecommendationResponse));
        when(mockGetWatchListStatusMovie.execute(tEvent.id))
            .thenAnswer((_) async => tIsAddedToWatchlist);
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        MovieDetailLoadingState(),
        MovieDetailFailureState(errorMessage: 'testErrorMessage'),
      ],
    );

    blocTest(
      'emit [MovieDetailLoadingState, MovieDetailLoadedState] '
      'on LoadMovieDetailEvent with Recommendation Failure',
      build: () {
        when(mockGetMovieDetail.execute(tEvent.id))
            .thenAnswer((_) async => Right(tMovieDetailResponse));
        when(mockGetMovieRecommendations.execute(tEvent.id)).thenAnswer(
            (_) async => Left(ConnectionFailure('testErrorMessage')));
        when(mockGetWatchListStatusMovie.execute(tEvent.id))
            .thenAnswer((_) async => tIsAddedToWatchlist);
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        MovieDetailLoadingState(),
        MovieDetailLoadedState(
          movieDetail: tMovieDetailResponse,
          isAddedToWatchlist: tIsAddedToWatchlist,
        ),
        MovieDetailLoadedState(
          movieDetail: tMovieDetailResponse,
          recommendationList: [],
          isAddedToWatchlist: tIsAddedToWatchlist,
        ),
      ],
    );
  });

  group('Add Watchlist', () {
    final tMovieDetailResponse = testMovieDetail;
    final tIsAddedToWatchlist = true;
    final tWatchlistMessage = 'tWatchlistMessage';

    final tEvent = AddWatchlistEvent(movieDetail: tMovieDetailResponse);

    blocTest(
      'emit [MovieDetailLoadedState]'
      'on AddWatchlistEvent successfully',
      build: () {
        when(mockSaveWatchlist.execute(tMovieDetailResponse))
            .thenAnswer((_) async => Right(tWatchlistMessage));
        when(mockGetWatchListStatusMovie.execute(tMovieDetailResponse.id))
            .thenAnswer((_) async => tIsAddedToWatchlist);
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        MovieDetailLoadedState(
          movieDetail: null,
          recommendationList: [],
          isAddedToWatchlist: tIsAddedToWatchlist,
          watchlistMessage: tWatchlistMessage,
        ),
      ],
    );

    blocTest(
      'emit [MovieDetailLoadedState]'
      'on AddWatchlistEvent with DatabaseFailure',
      build: () {
        when(mockSaveWatchlist.execute(tMovieDetailResponse))
            .thenAnswer((_) async => Left(DatabaseFailure(tWatchlistMessage)));
        when(mockGetWatchListStatusMovie.execute(tMovieDetailResponse.id))
            .thenAnswer((_) async => !tIsAddedToWatchlist);
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        MovieDetailLoadedState(
          movieDetail: null,
          recommendationList: [],
          isAddedToWatchlist: !tIsAddedToWatchlist,
          watchlistMessage: tWatchlistMessage,
        ),
      ],
    );
  });

  group('Remove Watchlist', () {
    final tMovieDetailResponse = testMovieDetail;
    final tIsAddedToWatchlist = true;
    final tWatchlistMessage = 'tWatchlistMessage';

    final tEvent = RemoveWatchlistEvent(movieDetail: tMovieDetailResponse);

    blocTest(
      'emit [MovieDetailLoadedState]'
      'on RemoveWatchlistEvent successfully',
      build: () {
        when(mockRemoveWatchlist.execute(tMovieDetailResponse))
            .thenAnswer((_) async => Right(tWatchlistMessage));
        when(mockGetWatchListStatusMovie.execute(tMovieDetailResponse.id))
            .thenAnswer((_) async => !tIsAddedToWatchlist);
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        MovieDetailLoadedState(
          movieDetail: null,
          recommendationList: [],
          isAddedToWatchlist: !tIsAddedToWatchlist,
          watchlistMessage: tWatchlistMessage,
        ),
      ],
    );

    blocTest(
      'emit [MovieDetailLoadedState]'
      'on RemoveWatchlistEvent with DatabaseFailure',
      build: () {
        when(mockRemoveWatchlist.execute(tMovieDetailResponse))
            .thenAnswer((_) async => Left(DatabaseFailure(tWatchlistMessage)));
        when(mockGetWatchListStatusMovie.execute(tMovieDetailResponse.id))
            .thenAnswer((_) async => tIsAddedToWatchlist);
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(tEvent),
      expect: () => [
        MovieDetailLoadedState(
          movieDetail: null,
          recommendationList: [],
          isAddedToWatchlist: tIsAddedToWatchlist,
          watchlistMessage: tWatchlistMessage,
        ),
      ],
    );
  });
}
