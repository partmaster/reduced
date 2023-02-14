// getit_binder.dart

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import '../../builder.dart';
import '../../domain.dart';
import 'getit_reduceable.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) {
    GetIt.instance.registerSingleton<ValueNotifier<MyAppState>>(
      ValueNotifier<MyAppState>(const MyAppState(title: 'get_it')),
    );
    return child;
  }
}

class MyHomePageBinder extends StatelessWidget with GetItMixin {
  MyHomePageBinder({super.key});

  @override
  Widget build(context) => MyHomePageBuilder(
        props: watchOnly<ValueNotifier<MyAppState>, MyHomePageProps>(
          (ValueNotifier<MyAppState> notifier) =>
              MyHomePageProps.reduceable(notifier.reduceable),
        ),
      );
}

class MyCounterWidgetBinder extends StatelessWidget with GetItMixin {
  MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => MyCounterWidgetBuilder(
        props: watchOnly<ValueNotifier<MyAppState>,
            MyCounterWidgetProps>(
          (ValueNotifier<MyAppState> notifier) =>
              MyCounterWidgetProps.reduceable(notifier.reduceable),
        ),
      );
}
