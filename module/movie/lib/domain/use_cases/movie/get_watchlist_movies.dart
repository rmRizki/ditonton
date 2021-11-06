import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie/movie.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:core/core.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
