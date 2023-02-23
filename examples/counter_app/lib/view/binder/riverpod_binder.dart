// riverpod_binder.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reduced_riverpod/reduced_riverpod.dart';
import 'package:reduced_riverpod/reduced_riverpod_wrapper.dart';

import '../../data/state.dart';
import '../../logic/transformer.dart';
import '../builder.dart';

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
        (state) => MyCounterWidgetPropsTransformer.transform(
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
        (state) => MyHomePagePropsTransformer.transform(
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
  Widget build(context) => wrapWithProvider(child: child);
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => wrapWithConsumer(
        builder: MyHomePageBuilder.new,
        provider: homePagePropsProvider,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => wrapWithConsumer(
        builder: MyCounterWidgetBuilder.new,
        provider: counterWidgetPropsProvider,
      );
}
