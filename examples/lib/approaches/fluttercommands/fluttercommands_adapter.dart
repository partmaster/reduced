// fluttercommands_adapter.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:reducible/reducible.dart';

import '../../widget/stateful_inherited_value_widget.dart';
import 'fluttercommands_reducible.dart';

Widget stateProviderAdapter<S>({
  required S initialState,
  required Widget child,
}) =>
    StatefulInheritedValueWidget(
      builder: (initialState) => ReducibleCommandStore(initialState),
      initializer: initialState,
      child: child,
    );

extension StateConsumerAdapter<S> on ReducibleCommandStore<S> {
  Widget stateConsumerAdapter<P>({
    required P Function(Reducible<S>) converter,
    required Widget Function({required P props}) builder,
  }) =>
      ValueListenableBuilder<P>(
        valueListenable: command.map((state) => converter(reducible)),
        builder: (_, props, ___) => builder(props: props),
      );
}
