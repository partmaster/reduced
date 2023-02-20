// mobx_binder.dart

import 'package:flutter/material.dart';
import 'package:reduced_mobx/reduced_mobx.dart';
import 'package:reduced_mobx/reduced_mobx_wrapper.dart';

import '../../data/state.dart';
import '../../data/props.dart';
import '../../logic/converter.dart';
import '../builder.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => wrapWithProvider(
        initialState: const MyAppState(title: 'mobx'),
        converter1: MyHomePagePropsConverter.convert,
        converter2: MyCounterWidgetPropsConverter.convert,
        child: child,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => context.store().wrapWithConsumer<MyHomePageProps>(
        props: (store) => store.p1,
        builder: MyHomePageBuilder.new,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) =>
      context.store().wrapWithConsumer<MyCounterWidgetProps>(
            props: (store) => store.p2,
            builder: MyCounterWidgetBuilder.new,
          );
}
