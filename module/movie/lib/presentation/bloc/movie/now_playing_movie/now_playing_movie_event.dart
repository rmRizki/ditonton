part of 'now_playing_movie_bloc.dart';

abstract class NowPlayingMovieEvent extends Equatable {
  const NowPlayingMovieEvent();
}

class LoadNowPlayingMovieEvent extends NowPlayingMovieEvent {
  @override
  List<Object?> get props => [];
}
