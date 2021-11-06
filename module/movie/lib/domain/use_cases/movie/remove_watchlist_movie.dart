import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/domain/entities/movie/movie_detail.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

class RemoveWatchlistMovie {
  final MovieRepository repository;

  RemoveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
