// binder_binder.dart

import 'package:flutter/widgets.dart';
import 'package:binder/binder.dart';
import 'package:reduced_binder/reduced_binder.dart';
import 'package:reduced_binder/reduced_binder_wrapper.dart';

import '../../data/state.dart';
import '../../logic/transformer.dart';
import '../builder.dart';

final stateRef = StateRef(
  const MyAppState(title: 'binder'),
);

final logicRef = LogicRef(
  (scope) => ReducibleLogic(scope, stateRef),
);

void registerState() {}

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => wrapWithScope(child: child);
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => context.logic(logicRef).wrapWithConsumer(
        stateRef: stateRef,
        builder: MyHomePageBuilder.new,
        transformer: MyHomePagePropsTransformer.transform,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => context.logic(logicRef).wrapWithConsumer(
        stateRef: stateRef,
        builder: MyCounterWidgetBuilder.new,
        transformer: MyCounterWidgetPropsTransformer.transform,
      );
}
