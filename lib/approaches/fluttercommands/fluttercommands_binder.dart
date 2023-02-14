// fluttercommands_binder.dart

import 'package:flutter/widgets.dart';

import '../../domain.dart';
import '../../builder.dart';
import '../../inherited_value_widget.dart';
import 'fluttercommands_reduceable.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;
  static final store = ReduceableCommandStore(
    const MyAppState(title: 'flutter_commands'),
  );

  @override
  Widget build(context) =>
      InheritedValueWidget(value: store, child: child);
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => context.store<MyAppState>().buildWidget(
        builder: MyHomePageBuilder.new,
        converter: MyHomePageProps.reduceable,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => context.store<MyAppState>().buildWidget(
        builder: MyCounterWidgetBuilder.new,
        converter: MyCounterWidgetProps.reduceable,
      );
}
