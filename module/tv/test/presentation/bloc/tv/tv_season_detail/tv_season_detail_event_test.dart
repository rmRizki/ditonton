import 'package:tv/presentation/bloc/tv/tv_season_detail/tv_season_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadTvSeasonDetailEvent', () {
    final tLoadTvSeasonDetailEvent = LoadTvSeasonDetailEvent(
      id: 0,
      seasonNumber: 0,
    );

    test(
      'make sure props value',
      () async {
        // assert
        expect(
          tLoadTvSeasonDetailEvent.props,
          [
            tLoadTvSeasonDetailEvent.id,
            tLoadTvSeasonDetailEvent.seasonNumber,
          ],
        );
      },
    );
  });
}
