// solidart_binder.dart

import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';

import '../../builder.dart';
import '../../domain.dart';
import 'solidart_reduceable.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => Solid(
        signals: {
          MyAppState: () => createSignal<MyAppState>(
                const MyAppState(title: 'solidart'),
              ),
        },
        child: Builder(builder: (context) => child),
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => context.signal<MyAppState>().buildWidget(
        converter: MyHomePageProps.reduceable,
        builder: MyHomePageBuilder.new,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => context.signal<MyAppState>().buildWidget(
        converter: MyCounterWidgetProps.reduceable,
        builder: MyCounterWidgetBuilder.new,
      );
}
