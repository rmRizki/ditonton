import 'package:tv/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadPopularTvEvent', () {
    final tLoadPopularTvEvent = LoadPopularTvEvent();

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadPopularTvEvent.props, []);
      },
    );
  });
}
