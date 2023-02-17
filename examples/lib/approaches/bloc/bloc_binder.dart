// bloc_binder.dart

import 'package:flutter/widgets.dart';

import '../../props.dart';
import '../../state.dart';
import '../../builder.dart';
import 'bloc_reducible.dart';
import 'bloc_adapter.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => stateProviderAdapter(
        initialState: const MyAppState(title: 'flutter_bloc'),
        child: child,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => context.bloc<MyAppState>().stateConsumerAdapter(
        builder: MyHomePageBuilder.new,
        converter: MyHomePageProps.reducible,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => context.bloc<MyAppState>().stateConsumerAdapter(
        builder: MyCounterWidgetBuilder.new,
        converter: MyCounterWidgetProps.reducible,
      );
}
