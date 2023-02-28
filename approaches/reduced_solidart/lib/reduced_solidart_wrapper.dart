// solidart_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
// ignore: implementation_imports
import 'package:solidart/src/core/signal_selector.dart';
import 'package:reduced/functions.dart';

import 'reduced_solidart.dart';

Widget wrapWithProvider<S>({
  required S initialState,
  required Widget child,
}) =>
    Solid(
      signals: {S: () => createSignal<S>(initialState)},
      child: Builder(builder: (context) => child),
    );

extension WrapWithConsumer<S> on Signal<S> {
  Widget wrapWithConsumer<P>({
    required ReducibleTransformer<S, P> transformer,
    required PropsWidgetBuilder<P> builder,
  }) =>
      SignalBuilder(
        signal: SignalSelector<S, P>(
          signal: this,
          selector: (_) => transformer(reducible),
          options: SignalOptions(comparator: (a, b) => a == b),
        ),
        builder: (_, value, ___) => builder(props: value),
      );
}
