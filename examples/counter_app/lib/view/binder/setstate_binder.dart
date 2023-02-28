// setstate_binder.dart

import 'package:flutter/widgets.dart';
import 'package:reduced_setstate/reduced_setstate_wrapper.dart';

import '../../data/state.dart';
import '../../logic/transformer.dart';
import '../builder.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => wrapWithProvider(
        initialState: const MyAppState(title: 'setState'),
        child: child,
        transformer1: MyHomePagePropsTransformer.transform,
        transformer2: MyCounterWidgetPropsTransformer.transform,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => wrapWithConsumer(builder: MyHomePageBuilder.new);
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) =>
      wrapWithConsumer(builder: MyCounterWidgetBuilder.new);
}
