// fluttercommands_binder.dart

import 'package:flutter/widgets.dart';

import '../../logic.dart';
import '../../builder.dart';
import 'fluttercommands_reducible.dart';
import 'fluttercommands_adapter.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => stateProviderAdapter(
        initialState: const MyAppState(title: 'flutter_commands'),
        child: child,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => context.store<MyAppState>().stateConsumerAdapter(
        builder: MyHomePageBuilder.new,
        converter: MyHomePageProps.reducible,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => context.store<MyAppState>().stateConsumerAdapter(
        builder: MyCounterWidgetBuilder.new,
        converter: MyCounterWidgetProps.reducible,
      );
}
