// reduced_setstate_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:inherited_widgets/inherited_widgets.dart';
import 'package:reduced/functions.dart';

import 'reduced_setstate.dart';

Widget wrapWithProvider<S, P1, P2>({
  required S initialState,
  required Widget child,
  required ReducibleTransformer<S, P1> transformer1,
  required ReducibleTransformer<S, P2> transformer2,
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

Widget wrapWithConsumer<S, P extends Object>({
  required PropsWidgetBuilder<P> builder,
}) =>
    Builder(
        builder: (context) => builder(
              props: InheritedValueWidget.of<P>(context),
            ));
