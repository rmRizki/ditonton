// Mocks generated by Mockito 5.0.16 from annotations
// in movie/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:convert' as _i25;
import 'dart:typed_data' as _i26;

import 'package:core/core.dart' as _i7;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/data/data_sources/movie_local_data_source.dart' as _i12;
import 'package:movie/data/data_sources/movie_remote_data_source.dart' as _i10;
import 'package:movie/data/models/movie/movie_detail_model.dart' as _i3;
import 'package:movie/data/models/movie/movie_model.dart' as _i11;
import 'package:movie/data/models/movie/movie_table.dart' as _i13;
import 'package:movie/domain/entities/movie/movie.dart' as _i8;
import 'package:movie/domain/entities/movie/movie_detail.dart' as _i9;
import 'package:movie/domain/repositories/movie_repository.dart' as _i4;
import 'package:movie/domain/use_cases/movie/get_movie_detail.dart' as _i18;
import 'package:movie/domain/use_cases/movie/get_movie_recommendations.dart'
    as _i19;
import 'package:movie/domain/use_cases/movie/get_now_playing_movies.dart'
    as _i15;
import 'package:movie/domain/use_cases/movie/get_popular_movies.dart' as _i16;
import 'package:movie/domain/use_cases/movie/get_top_rated_movies.dart' as _i17;
import 'package:movie/domain/use_cases/movie/get_watchlist_movies.dart' as _i24;
import 'package:movie/domain/use_cases/movie/get_watchlist_status_movie.dart'
    as _i23;
import 'package:movie/domain/use_cases/movie/remove_watchlist_movie.dart'
    as _i22;
import 'package:movie/domain/use_cases/movie/save_watchlist_movie.dart' as _i21;
import 'package:movie/domain/use_cases/movie/search_movies.dart' as _i20;
import 'package:sqflite/sqflite.dart' as _i14;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeMovieDetailResponse_1 extends _i1.Fake
    implements _i3.MovieDetailResponse {}

class _FakeMovieRepository_2 extends _i1.Fake implements _i4.MovieRepository {}

class _FakeResponse_3 extends _i1.Fake implements _i5.Response {}

class _FakeStreamedResponse_4 extends _i1.Fake implements _i5.StreamedResponse {
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i4.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i9.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, _i9.MovieDetail>>.value(
              _FakeEither_0<_i7.Failure, _i9.MovieDetail>())) as _i6
          .Future<_i2.Either<_i7.Failure, _i9.MovieDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveWatchlist(
          _i9.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeWatchlist(
          _i9.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i10.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i11.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<_i11.MovieModel>>.value(<_i11.MovieModel>[]))
          as _i6.Future<List<_i11.MovieModel>>);
  @override
  _i6.Future<List<_i11.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i11.MovieModel>>.value(<_i11.MovieModel>[]))
      as _i6.Future<List<_i11.MovieModel>>);
  @override
  _i6.Future<List<_i11.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i11.MovieModel>>.value(<_i11.MovieModel>[]))
      as _i6.Future<List<_i11.MovieModel>>);
  @override
  _i6.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1()))
          as _i6.Future<_i3.MovieDetailResponse>);
  @override
  _i6.Future<List<_i11.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i11.MovieModel>>.value(<_i11.MovieModel>[]))
          as _i6.Future<List<_i11.MovieModel>>);
  @override
  _i6.Future<List<_i11.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i11.MovieModel>>.value(<_i11.MovieModel>[]))
          as _i6.Future<List<_i11.MovieModel>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i12.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> insertWatchlist(_i13.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<String> removeWatchlist(_i13.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i13.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<_i13.MovieTable?>.value())
          as _i6.Future<_i13.MovieTable?>);
  @override
  _i6.Future<List<_i13.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<List<_i13.MovieTable>>.value(<_i13.MovieTable>[]))
      as _i6.Future<List<_i13.MovieTable>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i7.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i14.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i14.Database?>.value())
          as _i6.Future<_i14.Database?>);
  @override
  _i6.Future<int> insertWatchlist(String? table, Map<String, dynamic>? value) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [table, value]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<int> removeWatchlist(String? table, int? id) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [table, id]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<Map<String, dynamic>?> getDataById(String? table, int? id) =>
      (super.noSuchMethod(Invocation.method(#getDataById, [table, id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlist(String? table) =>
      (super.noSuchMethod(Invocation.method(#getWatchlist, [table]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i6.Future<List<Map<String, dynamic>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetNowPlayingMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowPlayingMovies extends _i1.Mock
    implements _i15.GetNowPlayingMovies {
  MockGetNowPlayingMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetPopularMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularMovies extends _i1.Mock implements _i16.GetPopularMovies {
  MockGetPopularMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetTopRatedMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedMovies extends _i1.Mock implements _i17.GetTopRatedMovies {
  MockGetTopRatedMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetMovieDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieDetail extends _i1.Mock implements _i18.GetMovieDetail {
  MockGetMovieDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i9.MovieDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, _i9.MovieDetail>>.value(
              _FakeEither_0<_i7.Failure, _i9.MovieDetail>())) as _i6
          .Future<_i2.Either<_i7.Failure, _i9.MovieDetail>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetMovieRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieRecommendations extends _i1.Mock
    implements _i19.GetMovieRecommendations {
  MockGetMovieRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SearchMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchMovies extends _i1.Mock implements _i20.SearchMovies {
  MockSearchMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> execute(String? query) =>
      (super.noSuchMethod(Invocation.method(#execute, [query]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SaveWatchlistMovie].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistMovie extends _i1.Mock
    implements _i21.SaveWatchlistMovie {
  MockSaveWatchlistMovie() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> execute(_i9.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [RemoveWatchlistMovie].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistMovie extends _i1.Mock
    implements _i22.RemoveWatchlistMovie {
  MockRemoveWatchlistMovie() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> execute(_i9.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetWatchListStatusMovie].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatusMovie extends _i1.Mock
    implements _i23.GetWatchListStatusMovie {
  MockGetWatchListStatusMovie() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i6.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistMovies extends _i1.Mock
    implements _i24.GetWatchlistMovies {
  MockGetWatchlistMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [BaseClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.BaseClient {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i6.Future<_i5.Response>);
  @override
  _i6.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i6.Future<_i5.Response>);
  @override
  _i6.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i6.Future<_i5.Response>);
  @override
  _i6.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i6.Future<_i5.Response>);
  @override
  _i6.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i6.Future<_i5.Response>);
  @override
  _i6.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i6.Future<_i5.Response>);
  @override
  _i6.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i26.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i26.Uint8List>.value(_i26.Uint8List(0)))
          as _i6.Future<_i26.Uint8List>);
  @override
  _i6.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i5.StreamedResponse>.value(_FakeStreamedResponse_4()))
          as _i6.Future<_i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
