// mobx_binder.dart

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../builder.dart';
import '../../domain.dart';
import '../../inherited_value_widget.dart';
import 'mobx_reduceable.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  static final store = MyStore(const MyAppState(title: 'mobx'));

  @override
  Widget build(context) => InheritedValueWidget(
        value: store,
        child: child,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) =>
      InheritedValueWidget.of<MyStore>(context).buildWidget(
        props: (store) => store.homePageProps,
        builder: MyHomePageBuilder.new,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) =>
      InheritedValueWidget.of<MyStore>(context).buildWidget(
        props: (store) => store.conterWidgetProps,
        builder: MyCounterWidgetBuilder.new,
      );
}
