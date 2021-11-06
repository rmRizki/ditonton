import 'package:core/core.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:tv/tv.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelper,
  GetOnTheAirTvs,
  GetPopularTvs,
  GetTopRatedTvs,
  GetTvDetail,
  GetTvRecommendations,
  SearchTvs,
  GetTvSeasonDetail,
  SaveWatchlistTv,
  RemoveWatchlistTv,
  GetWatchListStatusTv,
  GetWatchlistTvs,
], customMocks: [
  MockSpec<http.BaseClient>(as: #MockHttpClient)
])
void main() {}
