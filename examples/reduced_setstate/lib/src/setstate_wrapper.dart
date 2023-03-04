// setstate_wrapper.dart

import 'package:flutter/widgets.dart';
import 'inherited_widgets.dart';
import 'package:reduced/reduced.dart';

import 'setstate_reducible.dart';

Widget wrapWithProvider1<S, P1>({
  required S initialState,
  required Widget child,
  required ReducedTransformer<S, P1> transformer1,
}) =>
    ReducibleStatefulWidget(
      initialState: initialState,
      child: child,
      builder: (value, child) => InheritedValueWidget(
        value: transformer1(value),
        child: child,
      ),
    );

Widget wrapWithProvider2<S, P1, P2>({
  required S initialState,
  required Widget child,
  required ReducedTransformer<S, P1> transformer1,
  required ReducedTransformer<S, P2> transformer2,
}) =>
    ReducibleStatefulWidget(
      initialState: initialState,
      child: child,
      builder: (value, child) => InheritedValueWidget(
        value: transformer1(value),
        child: InheritedValueWidget(
          value: transformer2(value),
          child: child,
        ),
      ),
    );

Widget wrapWithConsumer<P extends Object>({
  required ReducedWidgetBuilder<P> builder,
}) =>
    Builder(
      builder: (context) => builder(
        props: InheritedValueWidget.of<P>(context),
      ),
    );
