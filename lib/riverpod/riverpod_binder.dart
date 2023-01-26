// riverpod_binder.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain.dart';
import '../builder.dart';
import 'riverpod.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.app});

  final MyAppBuilder app;

  @override
  Widget build(context) => ProviderScope(child: app);
}

class MyHomePageBinder extends ConsumerWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context, ref) => MyHomePageBuilder(
        props: MyHomePageProps.reduceable(ref.reduceable),
      );
}

class MyCounterWidgetBinder extends ConsumerWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context, ref) => MyCounterWidgetBuilder(
        props: MyCounterWidgetProps.reduceable(ref.reduceable),
      );
}
