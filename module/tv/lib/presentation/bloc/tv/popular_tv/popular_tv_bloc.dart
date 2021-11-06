import 'package:bloc/bloc.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/use_cases/tv/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTvs getPopularTvs;

  PopularTvBloc({
    required this.getPopularTvs,
  }) : super(PopularTvInitial()) {
    on<LoadPopularTvEvent>(_loadPopularTv);
  }

  void _loadPopularTv(
      LoadPopularTvEvent event, Emitter<PopularTvState> emit) async {
    emit(PopularTvLoadingState());

    var result = await getPopularTvs.execute();

    result.fold(
      (failure) {
        emit(PopularTvFailureState(errorMessage: failure.message));
      },
      (tvList) {
        emit(PopularTvLoadedState(tvList: tvList));
      },
    );
  }
}
