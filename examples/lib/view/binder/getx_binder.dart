// getx_binder.dart

import 'package:flutter/material.dart';
import 'package:reduced_getx/reduced_getx_wrapper.dart';

import '../../data/state.dart';
import '../../logic/converter.dart';
import '../builder.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => wrapWithProvider(
        initialState: const MyAppState(title: 'GetX'),
        child: child,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => wrapWithConsumer(
        builder: MyHomePageBuilder.new,
        converter: MyHomePagePropsConverter.convert,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => wrapWithConsumer(
        builder: MyCounterWidgetBuilder.new,
        converter: MyCounterWidgetPropsConverter.convert,
      );
}
