// statesrebuilder_binder.dart

import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../builder.dart';
import '../../domain.dart';
import '../../inherited_value_widget.dart';
import 'statesrebuilder_reduceable.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  static final store =
      Store(const MyAppState(title: 'states_rebuilder'));

  @override
  Widget build(context) => InheritedValueWidget(
        value: store,
        child: child,
      );
}

class MyHomePageBinder extends ReactiveStatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => context.store<MyAppState>().buildWidget(
        builder: MyHomePageBuilder.new,
        converter: MyHomePageProps.reduceable,
      );
}

class MyCounterWidgetBinder extends ReactiveStatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => context.store<MyAppState>().buildWidget(
        converter: MyCounterWidgetProps.reduceable,
        builder: MyCounterWidgetBuilder.new,
      );
}
