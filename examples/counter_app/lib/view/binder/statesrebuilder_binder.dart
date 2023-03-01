// statesrebuilder_binder.dart

import 'package:flutter/material.dart';
import 'package:reduced_statesrebuilder/reduced_statesrebuilder.dart';
import 'package:reduced_statesrebuilder/reduced_statesrebuilder_wrapper.dart';

import '../../data/state.dart';
import '../../logic/transformer.dart';
import '../builder.dart';

void registerState() {}

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => wrapWithProvider(
        initialState: const MyAppState(title: 'states_rebuilder'),
        child: child,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => context.store<MyAppState>().wrapWithConsumer(
        builder: MyHomePageBuilder.new,
        transformer: MyHomePagePropsTransformer.transform,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => context.store<MyAppState>().wrapWithConsumer(
        builder: MyCounterWidgetBuilder.new,
        transformer: MyCounterWidgetPropsTransformer.transform,
      );
}
