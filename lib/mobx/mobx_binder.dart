// mobx_binder.dart

import 'package:counter_app/mobx/mobx_reduceable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../builder.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => child;
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => Observer(
        builder: (_) => MyHomePageBuilder(
          props: store.homePageProps,
        ),
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => Observer(
        builder: (_) => MyCounterWidgetBuilder(
          props: store.conterWidgetProps,
        ),
      );
}
