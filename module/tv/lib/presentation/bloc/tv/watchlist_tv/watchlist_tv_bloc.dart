import 'package:bloc/bloc.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/use_cases/tv/get_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTvs getWatchlistTvs;

  WatchlistTvBloc({
    required this.getWatchlistTvs,
  }) : super(WatchlistTvInitial()) {
    on<LoadWatchlistTvEvent>(_loadWatchlistTv);
  }

  void _loadWatchlistTv(
      LoadWatchlistTvEvent event, Emitter<WatchlistTvState> emit) async {
    emit(WatchlistTvLoadingState());

    var result = await getWatchlistTvs.execute();

    result.fold(
      (failure) {
        emit(WatchlistTvFailureState(errorMessage: failure.message));
      },
      (tvList) {
        emit(WatchlistTvLoadedState(tvList: tvList));
      },
    );
  }
}
