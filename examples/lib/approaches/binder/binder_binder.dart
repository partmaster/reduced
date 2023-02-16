// binder_binder.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';

import '../../logic.dart';
import '../../builder.dart';
import 'binder_reduceable.dart';

final stateRef = StateRef(
  const MyAppState(title: 'binder'),
);

final logicRef = LogicRef(
  (scope) => ReduceableLogic(scope, stateRef),
);

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => binderWidget(child: child);
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => context.logic(logicRef).builderWidget(
        stateRef: stateRef,
        builder: MyHomePageBuilder.new,
        converter: MyHomePageProps.reduceable,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => context.logic(logicRef).builderWidget(
        stateRef: stateRef,
        builder: MyCounterWidgetBuilder.new,
        converter: MyCounterWidgetProps.reduceable,
      );
}
