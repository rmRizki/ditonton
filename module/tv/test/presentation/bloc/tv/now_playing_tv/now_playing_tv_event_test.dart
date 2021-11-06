import 'package:tv/presentation/bloc/tv/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadNowPlayingTvEvent', () {
    final tLoadNowPlayingTvEvent = LoadNowPlayingTvEvent();

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadNowPlayingTvEvent.props, []);
      },
    );
  });
}
