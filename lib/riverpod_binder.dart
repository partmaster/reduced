import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model.dart';
import 'reduceable_state.dart';
import 'builder.dart';

class MyAppStateNotifier extends StateNotifier<MyAppState> {
  MyAppStateNotifier()
      : super(const MyAppState(
          title: 'Flutter Demo Home Page',
          counter: 0,
        ));

  void reduce<V>(Reducer<MyAppState, V> reducer, V value) =>
      state = reducer(state, value);
}

final appStateProvider =
    StateNotifierProvider<MyAppStateNotifier, MyAppState>(
  (ref) => MyAppStateNotifier(),
);

class MyAppStateProvider extends StatelessWidget {
  const MyAppStateProvider({
    Key? key,
    required this.app,
  }) : super(key: key);

  final MyApp app;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: app);
  }
}

extension ReduceableStateOnWidgetRef on WidgetRef {
  ReduceableState<MyAppState> get reduceableState {
    final notifier = watch(appStateProvider.notifier);
    final state = watch(appStateProvider);
    return ReduceableState(state, notifier.reduce);
  }
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => Consumer(
        builder: (context, ref, _) => MyHomePageBuilder(
          props: MyHomePageProps.fromState(ref.reduceableState),
        ),
      );
}

class MyCounterWidgetBinder extends ConsumerWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context, ref) => MyCounterWidgetBuilder(
        props: MyCounterWidgetProps.fromState(ref.reduceableState),
      );
}
