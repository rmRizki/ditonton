part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object?> get props => [];
}

class TopRatedTvInitial extends TopRatedTvState {}

class TopRatedTvLoadingState extends TopRatedTvState {}

class TopRatedTvLoadedState extends TopRatedTvState {
  final List<Tv>? tvList;

  TopRatedTvLoadedState({
    required this.tvList,
  });

  @override
  List<Object?> get props => [tvList];
}

class TopRatedTvFailureState extends TopRatedTvState {
  final String? errorMessage;

  TopRatedTvFailureState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
