// consumer.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced_setstate/reduced_setstate.dart';

import 'props.dart';

class MyHomePagePropsConsumer extends StatelessWidget {
  const MyHomePagePropsConsumer({
    super.key,
    required this.builder,
  });

  final ReducedWidgetBuilder<MyHomePageProps> builder;

  @override
  Widget build(BuildContext context) => wrapWithConsumer(builder: builder);
}

class MyCounterWidgetPropsConsumer extends StatelessWidget {
  const MyCounterWidgetPropsConsumer({
    super.key,
    required this.builder,
  });

  final ReducedWidgetBuilder<MyCounterWidgetProps> builder;

  @override
  Widget build(context) => wrapWithConsumer(builder: builder);
}
