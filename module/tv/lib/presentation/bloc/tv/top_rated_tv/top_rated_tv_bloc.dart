import 'package:bloc/bloc.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/use_cases/tv/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTvs getTopRatedTvs;

  TopRatedTvBloc({
    required this.getTopRatedTvs,
  }) : super(TopRatedTvInitial()) {
    on<LoadTopRatedTvEvent>(_loadTopRatedTv);
  }

  void _loadTopRatedTv(
      LoadTopRatedTvEvent event, Emitter<TopRatedTvState> emit) async {
    emit(TopRatedTvLoadingState());

    var result = await getTopRatedTvs.execute();

    result.fold(
      (failure) {
        emit(TopRatedTvFailureState(errorMessage: failure.message));
      },
      (tvList) {
        emit(TopRatedTvLoadedState(tvList: tvList));
      },
    );
  }
}
