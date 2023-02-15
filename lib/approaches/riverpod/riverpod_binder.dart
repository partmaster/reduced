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
  (ref) =>
      ReduceableStateNotifier(const MyAppState(title: 'riverpod')),
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

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => buildWidget(
        builder: MyHomePageBuilder.new,
        provider: homePagePropsProvider,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => buildWidget(
        builder: MyCounterWidgetBuilder.new,
        provider: counterWidgetPropsProvider,
      );
}
