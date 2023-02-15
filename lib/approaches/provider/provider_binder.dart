// provider_binder.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../builder.dart';
import '../../domain.dart';
import 'provider_reduceable.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) =>
      ChangeNotifierProvider<ValueNotifier<MyAppState>>(
        create: (context) => ValueNotifier<MyAppState>(
            const MyAppState(title: 'provider')),
        child: child,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => buildWidget(
        builder: MyHomePageBuilder.new,
        converter: MyHomePageProps.reduceable,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => buildWidget(
        builder: MyCounterWidgetBuilder.new,
        converter: MyCounterWidgetProps.reduceable,
      );
}
