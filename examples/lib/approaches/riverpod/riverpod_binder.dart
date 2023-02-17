// riverpod_binder.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../builder.dart';
import '../../props.dart';
import '../../state.dart';
import 'riverpod_adapter.dart';
import 'riverpod_reducible.dart';

typedef MyAppStateNotifier = ReducibleStateNotifier<MyAppState>;
typedef MyAppStateProvider
    = StateNotifierProvider<MyAppStateNotifier, MyAppState>;

final appStateProvider = MyAppStateProvider(
  (ref) =>
      ReducibleStateNotifier(const MyAppState(title: 'riverpod')),
);

final counterWidgetPropsProvider = StateProvider(
  (ref) {
    final appStateNotifier = ref.watch(appStateProvider.notifier);
    return ref.watch(
      appStateProvider.select(
        (state) => MyCounterWidgetProps.reducible(
          appStateNotifier.reducible,
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
        (state) => MyHomePageProps.reducible(
          appStateNotifier.reducible,
        ),
      ),
    );
  },
);

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => stateProviderAdapter(child: child);
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => stateConsumerAdapter(
        builder: MyHomePageBuilder.new,
        provider: homePagePropsProvider,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => stateConsumerAdapter(
        builder: MyCounterWidgetBuilder.new,
        provider: counterWidgetPropsProvider,
      );
}
