import 'package:tv/presentation/bloc/tv/tv_search/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadTvSearchEvent', () {
    final tLoadTvSearchEvent = LoadTvSearchEvent(query: '');

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadTvSearchEvent.props, [tLoadTvSearchEvent.query]);
      },
    );
  });
}
