// mobx_binder.dart

import 'package:flutter/material.dart';

import '../../view/builder.dart';
import '../../data/state.dart';
import '../../widget/inherited_value_widget.dart';
import 'mobx_wrapper.dart';
import 'mobx_reducible.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  static final store = MyStore(const MyAppState(title: 'mobx'));

  @override
  Widget build(context) => wrapWithProvider(store: store, child: child);
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) =>
      InheritedValueWidget.of<MyStore>(context).wrapWithConsumer(
        props: (store) => store.homePageProps,
        builder: MyHomePageBuilder.new,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) =>
      InheritedValueWidget.of<MyStore>(context).wrapWithConsumer(
        props: (store) => store.conterWidgetProps,
        builder: MyCounterWidgetBuilder.new,
      );
}
