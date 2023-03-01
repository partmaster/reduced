// getx_binder.dart

import 'package:flutter/material.dart';
import 'package:reduced_getx/reduced_getx_wrapper.dart' as wrapper;

import '../../data/state.dart';
import '../../logic/transformer.dart';
import '../builder.dart';

void registerState() => wrapper.registerState(
      initialState: const MyAppState(title: 'GetX'),
    );

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => child;
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
