// getit_binder.dart

import 'package:flutter/material.dart';

import '../../view/builder.dart';
import '../../data/props.dart';
import '../../data/state.dart';
import 'getit_adapter.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => stateProviderAdapter(
        initialState: const MyAppState(title: 'GetIt'),
        child: child,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => stateConsumerAdapter(
        builder: MyHomePageBuilder.new,
        converter: MyHomePageProps.reducible,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => stateConsumerAdapter(
        builder: MyCounterWidgetBuilder.new,
        converter: MyCounterWidgetProps.reducible,
      );
}
