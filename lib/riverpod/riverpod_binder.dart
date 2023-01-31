// riverpod_binder.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../builder.dart';
import 'riverpod.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => ProviderScope(child: child);
}

class MyHomePageBinder extends ConsumerWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context, ref) => MyHomePageBuilder(
        props: ref.watch(homePagePropsProvider),
      );
}

class MyCounterWidgetBinder extends ConsumerWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context, ref) => MyCounterWidgetBuilder(
        props: ref.watch(counterWidgetPropsProvider),
      );
}
