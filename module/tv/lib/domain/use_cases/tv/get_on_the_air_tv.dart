import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:core/core.dart';

class GetOnTheAirTvs {
  final TvRepository repository;

  GetOnTheAirTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getOnTheAirTvs();
  }
}
