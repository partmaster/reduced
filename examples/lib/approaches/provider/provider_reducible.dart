// provider_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reducible/reducible.dart';

extension ReduceableValueNotifier<S> on ValueNotifier<S> {
  S getState() => value;

  void reduce(Reducer<S> reducer) {
    value = reducer(value);
  }

  Reducible<S> get reducible =>
      Reducible(getState, reduce, this);
}

Widget binderWidget<S>({
  required S initialState,
  required Widget child,
}) =>
    ChangeNotifierProvider<ValueNotifier<S>>(
      create: (context) => ValueNotifier<S>(initialState),
      child: child,
    );

Widget builderWidget<S, P>({
  required P Function(Reducible<S>) converter,
  required Widget Function({Key? key, required P props}) builder,
}) =>
    Selector<ValueNotifier<S>, P>(
      builder: (context, props, _) => builder(props: props),
      selector: (context, notifier) => converter(notifier.reducible),
    );

