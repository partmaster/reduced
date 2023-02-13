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

Widget signalBuilder<S, P>(
  Signal<S> signal,
  P Function(Reduceable<S>) selector,
  Widget Function({Key? key, required P props}) builder,
) =>
    SignalBuilder(
      signal: SignalSelector<S, P>(
        signal: signal,
        selector: (_) => selector(signal.reduceable),
        options: SignalOptions(comparator: (a, b) => a == b),
      ),
      builder: (_, value, ___) => builder(props: value),
    );
