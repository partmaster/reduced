// fluttertriple_binder.dart

import 'package:flutter/widgets.dart';
import 'package:reduceable/approaches/fluttertriple/fluttertriple_reduceable.dart';

import '../../domain.dart';
import '../../builder.dart';
import '../../inherited_value_widget.dart';

typedef MyStore = ReduceableStreamStore<MyAppState>;

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  static final store = MyStore(
    const MyAppState(
      title: 'Flutter Demo Home Page',
      counter: 0,
    ),
  );

  @override
  Widget build(context) => InheritedValueWidget(
        value: store,
        child: child,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => scopedBuilder(
        store: InheritedValueWidget.of<MyStore>(context),
        converter: MyHomePageProps.reduceable,
        builder: MyHomePageBuilder.new,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => scopedBuilder(
        store: InheritedValueWidget.of<MyStore>(context),
        converter: MyCounterWidgetProps.reduceable,
        builder: MyCounterWidgetBuilder.new,
      );
}
