part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object?> get props => [];
}

class PopularTvInitial extends PopularTvState {}

class PopularTvLoadingState extends PopularTvState {}

class PopularTvLoadedState extends PopularTvState {
  final List<Tv>? tvList;

  PopularTvLoadedState({
    required this.tvList,
  });

  @override
  List<Object?> get props => [tvList];
}

class PopularTvFailureState extends PopularTvState {
  final String? errorMessage;

  PopularTvFailureState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
