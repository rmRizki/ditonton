import 'package:tv/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  group('LoadTvDetailEvent', () {
    final tLoadTvDetailEvent = LoadTvDetailEvent(id: 0);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadTvDetailEvent.props, [tLoadTvDetailEvent.id]);
      },
    );
  });

  group('AddWatchlistEvent', () {
    final tAddWatchlistEvent = AddWatchlistEvent(tvDetail: testTvDetail);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tAddWatchlistEvent.props, [tAddWatchlistEvent.tvDetail]);
      },
    );
  });

  group('RemoveWatchlistEvent', () {
    final tRemoveWatchlistEvent = RemoveWatchlistEvent(tvDetail: testTvDetail);

    test(
      'make sure props value',
      () async {
        // assert
        expect(tRemoveWatchlistEvent.props, [tRemoveWatchlistEvent.tvDetail]);
      },
    );
  });
}
