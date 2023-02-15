// solidart_reduceable.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
// ignore: implementation_imports
import 'package:solidart/src/core/signal_selector.dart';

import '../../reduceable.dart';

extension ReduceableSignal<S> on Signal<S> {
  S getState() => value;

  void reduce(Reducer<S> reducer) => value = reducer(value);

  Reduceable<S> get reduceable => Reduceable(getState, reduce, this);
}

extension BuildWidgetExtension<S> on Signal<S> {
  Widget buildWidget<P>({
    required P Function(Reduceable<S>) converter,
    required Widget Function({Key? key, required P props}) builder,
  }) =>
      SignalBuilder(
        signal: SignalSelector<S, P>(
          signal: this,
          selector: (_) => converter(reduceable),
          options: SignalOptions(comparator: (a, b) => a == b),
        ),
        builder: (_, value, ___) => builder(props: value),
      );
}

extension StoreOnBuildContext on BuildContext {
  Signal<S> store<S>() => get<Signal<S>>(S);
}
