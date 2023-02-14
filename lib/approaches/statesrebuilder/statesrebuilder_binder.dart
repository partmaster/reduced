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
  Widget build(context) {
    final store = InheritedValueWidget.of<Store<MyAppState>>(context);
    return OnBuilder<MyAppState>(
      listenTo: store.value,
      shouldRebuild: (p0, p1) => shouldRebuild(
        p0.data as MyAppState,
        p1.data as MyAppState,
        store.reduceable.reduce,
        MyHomePageProps.reduceable,
      ),
      builder: () => MyHomePageBuilder(
        props: MyHomePageProps.reduceable(store.reduceable),
      ),
    );
  }
}

class MyCounterWidgetBinder extends ReactiveStatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) {
    final store = InheritedValueWidget.of<Store<MyAppState>>(context);
    return OnBuilder<MyAppState>(
      listenTo: store.value,
      shouldRebuild: (p0, p1) => shouldRebuild(
        p0.data as MyAppState,
        p1.data as MyAppState,
        store.reduceable.reduce,
        MyCounterWidgetProps.reduceable,
      ),
      builder: () => MyCounterWidgetBuilder(
        props: MyCounterWidgetProps.reduceable(store.reduceable),
      ),
    );
  }
}
