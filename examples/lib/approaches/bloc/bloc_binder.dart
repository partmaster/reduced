// bloc_binder.dart

import 'package:flutter/widgets.dart';

import '../../data/state.dart';
import '../../logic/converter.dart';
import '../../view/builder.dart';
import 'bloc_reducible.dart';
import 'bloc_wrapper.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => wrapWithProvider(
        initialState: const MyAppState(title: 'flutter_bloc'),
        child: child,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => context.bloc<MyAppState>().wrapWithConsumer(
        builder: MyHomePageBuilder.new,
        converter: MyHomePagePropsConverter.convert,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => context.bloc<MyAppState>().wrapWithConsumer(
        builder: MyCounterWidgetBuilder.new,
        converter: MyCounterWidgetPropsConverter.convert,
      );
}
