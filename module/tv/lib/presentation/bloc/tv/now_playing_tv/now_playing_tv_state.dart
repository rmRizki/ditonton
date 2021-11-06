part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object?> get props => [];
}

class NowPlayingTvInitial extends NowPlayingTvState {}

class NowPlayingTvLoadingState extends NowPlayingTvState {}

class NowPlayingTvLoadedState extends NowPlayingTvState {
  final List<Tv>? tvList;

  NowPlayingTvLoadedState({
    required this.tvList,
  });

  @override
  List<Object?> get props => [tvList];
}

class NowPlayingTvFailureState extends NowPlayingTvState {
  final String? errorMessage;

  NowPlayingTvFailureState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
