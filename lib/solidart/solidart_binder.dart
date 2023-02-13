// solidart_binder.dart

import 'package:counter_app/solidart/solidart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';

import '../builder.dart';
import '../domain.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => Solid(
        signals: {
          MyAppState: () => createSignal<MyAppState>(
                const MyAppState(
                  title: 'Flutter Demo Home Page',
                  counter: 0,
                ),
              ),
        },
        child: Builder(builder: (context) => child),
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => signalBuilder(
        context.get<Signal<MyAppState>>(MyAppState),
        MyHomePageProps.reduceable,
        MyHomePageBuilder.new,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => signalBuilder(
        context.get<Signal<MyAppState>>(MyAppState),
        MyCounterWidgetProps.reduceable,
        MyCounterWidgetBuilder.new,
      );
}
