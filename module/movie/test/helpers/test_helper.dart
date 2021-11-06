import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movie/movie.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetMovieDetail,
  GetMovieRecommendations,
  SearchMovies,
  SaveWatchlistMovie,
  RemoveWatchlistMovie,
  GetWatchListStatusMovie,
  GetWatchlistMovies,
], customMocks: [
  MockSpec<http.BaseClient>(as: #MockHttpClient)
])
void main() {}
