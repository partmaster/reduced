// statesrebuilder_binder.dart

import 'package:flutter/material.dart';

import '../../builder.dart';
import '../../domain.dart';
import 'statesrebuilder_reduceable.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  static final store =
      Store(const MyAppState(title: 'states_rebuilder'));

  @override
  Widget build(context) => binderWidget(store: store, child: child);
}



class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => context.store<MyAppState>().builderWidget(
        builder: MyHomePageBuilder.new,
        converter: MyHomePageProps.reduceable,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => context.store<MyAppState>().builderWidget(
        converter: MyCounterWidgetProps.reduceable,
        builder: MyCounterWidgetBuilder.new,
      );
}
