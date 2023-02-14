// binder_binder.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';

import '../../domain.dart';
import '../../builder.dart';
import 'binder_reduceable.dart';

final stateRef = StateRef(
  const MyAppState(
    title: 'Flutter Demo Home Page',
    counter: 0,
  ),
);

final logicRef = LogicRef(
  (scope) => ReduceableLogic(scope, stateRef),
);

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => BinderScope(child: child);
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => createConsumer(
      stateRef: stateRef,
      logic: context.readScope().use(logicRef),
      converter: MyHomePageProps.reduceable,
      builder: MyHomePageBuilder.new);
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => createConsumer(
        stateRef: stateRef,
        logic: context.readScope().use(logicRef),
        converter: MyCounterWidgetProps.reduceable,
        builder: MyCounterWidgetBuilder.new,
      );
}
