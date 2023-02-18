// riverpod_binder.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/converter.dart';
import '../../view/builder.dart';
import '../../data/state.dart';
import 'riverpod_injector.dart';
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
        (state) => MyCounterWidgetPropsConverter.convert(
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
        (state) => MyHomePagePropsConverter.convert(
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
  Widget build(context) => injectStateProvider(child: child);
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => injectStateConsumer(
        builder: MyHomePageBuilder.new,
        provider: homePagePropsProvider,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => injectStateConsumer(
        builder: MyCounterWidgetBuilder.new,
        provider: counterWidgetPropsProvider,
      );
}
