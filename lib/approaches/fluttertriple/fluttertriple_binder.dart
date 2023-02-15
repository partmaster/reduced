// fluttertriple_binder.dart

import 'package:flutter/widgets.dart';

import '../../domain.dart';
import '../../builder.dart';
import 'fluttertriple_reduceable.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  static final store = ReduceableStreamStore<MyAppState>(
    const MyAppState(title: 'flutter_triple'),
  );

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
        builder: MyCounterWidgetBuilder.new,
        converter: MyCounterWidgetProps.reduceable,
      );
}
