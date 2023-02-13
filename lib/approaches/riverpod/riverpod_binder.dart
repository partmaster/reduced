// riverpod_binder.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../builder.dart';
import '../../domain.dart';
import 'riverpod_reduceable.dart';

typedef MyAppStateNotifier = ReduceableStateNotifier<MyAppState>;
typedef MyAppStateProvider
    = StateNotifierProvider<MyAppStateNotifier, MyAppState>;

final appStateProvider = MyAppStateProvider(
  (ref) => ReduceableStateNotifier(
    const MyAppState(
      title: 'Flutter Demo Home Page',
      counter: 0,
    ),
  ),
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

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => ProviderScope(child: child);
}

class MyHomePageBinder extends ConsumerWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context, ref) => MyHomePageBuilder(
        props: ref.watch(homePagePropsProvider),
      );
}

class MyCounterWidgetBinder extends ConsumerWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context, ref) => MyCounterWidgetBuilder(
        props: ref.watch(counterWidgetPropsProvider),
      );
}
