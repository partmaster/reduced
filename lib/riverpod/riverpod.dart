// riverpod.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain.dart';
import '../reduceable.dart';

class MyAppStateNotifier extends StateNotifier<MyAppState> {
  MyAppStateNotifier()
      : super(const MyAppState(
          title: 'riverpod',
          counter: 0,
        ));

  void reduce(Reducer<MyAppState> reducer) => state = reducer(state);
}

final appStateProvider =
    StateNotifierProvider<MyAppStateNotifier, MyAppState>(
  (ref) => MyAppStateNotifier(),
);

extension ReduceableOnWidgetRef on WidgetRef {
  Reduceable<MyAppState> get reduceable => Reduceable(
        watch(appStateProvider),
        watch(appStateProvider.notifier).reduce,
      );
}
