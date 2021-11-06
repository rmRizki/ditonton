import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/use_cases/tv/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvs searchTvs;

  TvSearchBloc({
    required this.searchTvs,
  }) : super(TvSearchInitial()) {
    on<LoadTvSearchEvent>(
      _loadTvSearch,
      transformer: (events, mapper) => restartable<LoadTvSearchEvent>().call(
        events.debounceTime(Duration(milliseconds: 500)),
        mapper,
      ),
    );
  }

  void _loadTvSearch(
      LoadTvSearchEvent event, Emitter<TvSearchState> emit) async {
    emit(TvSearchLoadingState());

    var result = await searchTvs.execute(event.query);

    result.fold(
      (failure) {
        emit(TvSearchFailureState(errorMessage: failure.message));
      },
      (tvList) {
        emit(TvSearchLoadedState(tvList: tvList));
      },
    );
  }
}
