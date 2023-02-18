// solidart_adapter.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
// ignore: implementation_imports
import 'package:solidart/src/core/signal_selector.dart';

import '../../typedefs.dart';
import 'solidart_reducible.dart';

Widget injectStateProvider<S>({
  required S initialState,
  required Widget child,
}) =>
    Solid(
      signals: {S: () => createSignal<S>(initialState)},
      child: Builder(builder: (context) => child),
    );

extension InjectStateConsumer<S> on Signal<S> {
  Widget injectStateConsumer<P>({
    required ReducibleConverter<S, P> converter,
    required PropsWidgetBuilder<P> builder,
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
