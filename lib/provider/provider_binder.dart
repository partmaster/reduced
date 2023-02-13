// provider_binder.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../builder.dart';
import '../domain.dart';
import 'provider_reduceable.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) =>
      ChangeNotifierProvider<ValueNotifier<MyAppState>>(
        create: (context) => ValueNotifier<MyAppState>(
          const MyAppState(
            title: 'Flutter Demo Home Page',
            counter: 0,
          ),
        ),
        child: child,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) =>
      Selector<ValueNotifier<MyAppState>, MyHomePageProps>(
        builder: (context, props, _) =>
            MyHomePageBuilder(props: props),
        selector: (context, notifier) =>
            MyHomePageProps.reduceable(notifier.reduceable),
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) =>
      Selector<ValueNotifier<MyAppState>, MyCounterWidgetProps>(
        builder: (context, props, _) =>
            MyCounterWidgetBuilder(props: props),
        selector: (context, notifier) =>
            MyCounterWidgetProps.reduceable(notifier.reduceable),
      );
}
