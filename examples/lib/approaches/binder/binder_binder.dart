// binder_binder.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';

import '../../props.dart';
import '../../state.dart';
import '../../builder.dart';
import 'binder_reducible.dart';
import 'binder_adapter.dart';

final stateRef = StateRef(
  const MyAppState(title: 'binder'),
);

final logicRef = LogicRef(
  (scope) => ReducibleLogic(scope, stateRef),
);

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => stateProviderAdapter(child: child);
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => context.logic(logicRef).stateConsumerAdapter(
        stateRef: stateRef,
        builder: MyHomePageBuilder.new,
        converter: MyHomePageProps.reducible,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => context.logic(logicRef).stateConsumerAdapter(
        stateRef: stateRef,
        builder: MyCounterWidgetBuilder.new,
        converter: MyCounterWidgetProps.reducible,
      );
}
