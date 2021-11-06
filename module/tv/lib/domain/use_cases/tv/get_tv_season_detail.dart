import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/season/season_detail.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:core/core.dart';

class GetTvSeasonDetail {
  final TvRepository repository;

  GetTvSeasonDetail(this.repository);

  Future<Either<Failure, SeasonDetail>> execute(int id, int seasonNumber) {
    return repository.getTvSeasonDetail(id, seasonNumber);
  }
}
