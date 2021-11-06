import 'package:bloc/bloc.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/use_cases/tv/get_on_the_air_tv.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetOnTheAirTvs getOnTheAirTvs;

  NowPlayingTvBloc({
    required this.getOnTheAirTvs,
  }) : super(NowPlayingTvInitial()) {
    on<LoadNowPlayingTvEvent>(_loadNowPlayingTv);
  }

  void _loadNowPlayingTv(
      LoadNowPlayingTvEvent event, Emitter<NowPlayingTvState> emit) async {
    emit(NowPlayingTvLoadingState());

    var result = await getOnTheAirTvs.execute();

    result.fold(
      (failure) {
        emit(NowPlayingTvFailureState(errorMessage: failure.message));
      },
      (tvList) {
        emit(NowPlayingTvLoadedState(tvList: tvList));
      },
    );
  }
}
