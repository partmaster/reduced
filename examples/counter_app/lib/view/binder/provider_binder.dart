// provider_binder.dart

import 'package:flutter/material.dart';
import 'package:reduced_provider/reduced_provider_wrapper.dart';

import '../../data/state.dart';
import '../../logic/transformer.dart';
import '../builder.dart';

void registerState() {}

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => wrapWithProvider(
        initialState: const MyAppState(title: 'provider'),
        child: child,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => wrapWithConsumer(
        builder: MyHomePageBuilder.new,
        transformer: MyHomePagePropsTransformer.transform,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => wrapWithConsumer(
        builder: MyCounterWidgetBuilder.new,
        transformer: MyCounterWidgetPropsTransformer.transform,
      );
}
