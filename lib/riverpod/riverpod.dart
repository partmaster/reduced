// riverpod.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain.dart';
import '../reduceable.dart';

class MyAppStateNotifier extends StateNotifier<MyAppState> {
  MyAppStateNotifier()
      : super(const MyAppState(
          title: 'Flutter Demo Home Page',
          counter: 0,
        ));

  late final reduceable = Reduceable(getState, reduce, this);

  MyAppState getState() => super.state;

  void reduce(Reducer<MyAppState> reducer) => state = reducer(state);
}

final appStateProvider =
    StateNotifierProvider<MyAppStateNotifier, MyAppState>(
  (ref) => MyAppStateNotifier(),
);

final counterWidgetPropsProvider = StateProvider(
  (ref) {
    final appStateNotifier = ref.watch(appStateProvider.notifier);
    return ref.watch(
      appStateProvider.select(
        (state) => MyCounterWidgetProps.reduceable(
          appStateNotifier.reduceable,
        ),
      ),
    );
  },
);

//
//
//
// </br>
final homePagePropsProvider = StateProvider(
  (ref) {
    final appStateNotifier = ref.watch(appStateProvider.notifier);
    return ref.watch(
      appStateProvider.select(
        (state) => MyHomePageProps.reduceable(
          appStateNotifier.reduceable,
        ),
      ),
    );
  },
);
