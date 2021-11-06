import 'package:tv/presentation/bloc/tv/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadTopRatedTvEvent', () {
    final tLoadTopRatedTvEvent = LoadTopRatedTvEvent();

    test(
      'make sure props value',
      () async {
        // assert
        expect(tLoadTopRatedTvEvent.props, []);
      },
    );
  });
}
