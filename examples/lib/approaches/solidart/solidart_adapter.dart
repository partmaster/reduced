// solidart_adapter.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
// ignore: implementation_imports
import 'package:solidart/src/core/signal_selector.dart';
import 'package:reducible/reducible.dart';

import 'solidart_reducible.dart';

Widget stateProviderAdapter<S>({
  required S initialState,
  required Widget child,
}) =>
    Solid(
      signals: {S: () => createSignal<S>(initialState)},
      child: Builder(builder: (context) => child),
    );

extension StateConsumerAdapter<S> on Signal<S> {
  Widget stateConsumerAdapter<P>({
    required P Function(Reducible<S>) converter,
    required Widget Function({Key? key, required P props}) builder,
  }) =>
      SignalBuilder(
        signal: SignalSelector<S, P>(
          signal: this,
          selector: (_) => converter(reducible),
          options: SignalOptions(comparator: (a, b) => a == b),
        ),
        builder: (_, value, ___) => builder(props: value),
      );
}
