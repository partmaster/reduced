// fluttertriple_binder.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_triple/flutter_triple.dart';
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
  Widget build(context) {
    final store = InheritedValueWidget.of<MyStore>(context);
    final reduceable = store.reduceable;
    return ScopedBuilder<MyStore, Object, MyAppState>(
      store: store,
      distinct: (_) => MyHomePageProps.reduceable(reduceable),
      onState: (_, state) => MyHomePageBuilder(
        props: MyHomePageProps.reduceable(reduceable),
      ),
    );
  }
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) {
    final store = InheritedValueWidget.of<MyStore>(context);
    final reduceable = store.reduceable;
    return ScopedBuilder<MyStore, Object, MyAppState>(
      store: store,
      distinct: (_) => MyCounterWidgetProps.reduceable(reduceable),
      onState: (_, __) => MyCounterWidgetBuilder(
        props: MyCounterWidgetProps.reduceable(reduceable),
      ),
    );
  }
}
