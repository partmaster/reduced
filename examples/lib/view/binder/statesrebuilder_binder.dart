// statesrebuilder_binder.dart

import 'package:flutter/material.dart';
import 'package:reduced_statesrebuilder/reduced_statesrebuilder.dart';
import 'package:reduced_statesrebuilder/reduced_statesrebuilder_wrapper.dart';

import '../../data/state.dart';
import '../../logic/converter.dart';
import '../builder.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  static final store =
      Store(const MyAppState(title: 'states_rebuilder'));

  @override
  Widget build(context) => wrapWithProvider(store: store, child: child);
}



class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => context.store<MyAppState>().wrapWithConsumer(
        builder: MyHomePageBuilder.new,
        converter: MyHomePagePropsConverter.convert,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => context.store<MyAppState>().wrapWithConsumer(
        builder: MyCounterWidgetBuilder.new,
        converter: MyCounterWidgetPropsConverter.convert,
      );
}
