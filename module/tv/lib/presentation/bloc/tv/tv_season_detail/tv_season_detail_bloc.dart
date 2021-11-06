import 'package:bloc/bloc.dart';
import 'package:tv/domain/entities/season/season_detail.dart';
import 'package:tv/domain/use_cases/tv/get_tv_season_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_season_detail_event.dart';
part 'tv_season_detail_state.dart';

class TvSeasonDetailBloc
    extends Bloc<TvSeasonDetailEvent, TvSeasonDetailState> {
  final GetTvSeasonDetail getTvSeasonDetail;

  TvSeasonDetailBloc({
    required this.getTvSeasonDetail,
  }) : super(TvSeasonDetailInitial()) {
    on<LoadTvSeasonDetailEvent>(_loadTvSeasonDetail);
  }

  void _loadTvSeasonDetail(
      LoadTvSeasonDetailEvent event, Emitter<TvSeasonDetailState> emit) async {
    emit(TvSeasonDetailLoadingState());

    var result = await getTvSeasonDetail.execute(event.id, event.seasonNumber);

    result.fold(
      (failure) {
        emit(TvSeasonDetailFailureState(errorMessage: failure.message));
      },
      (seasonDetail) {
        emit(TvSeasonDetailLoadedState(seasonDetail: seasonDetail));
      },
    );
  }
}
