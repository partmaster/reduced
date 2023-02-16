// fluttercommands_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:reduceable/reducible.dart';

import '../../util/inherited_value_widget.dart';
import '../../util/stateful_inherited_value_widget.dart';

class ReducibleCommandStore<S> {
  ReducibleCommandStore(S initialState) : _state = initialState;

  S _state;

  late final command = Command.createSync((Reducer<S> reducer) {
    _state = reducer(_state);
    return _state;
  }, _state);

  late final Reducible<S> reducible = Reducible(() => _state, command, this);
}

Widget binderWidget<S>({
  required S initialState,
  required Widget child,
}) =>
    StatefulInheritedValueWidget(
      builder: (initialState) => ReducibleCommandStore(initialState),
      initializer: initialState,
      child: child,
    );

extension BuilderWidgetExtension<S> on ReducibleCommandStore<S> {
  Widget builderWidget<P>({
    required P Function(Reducible<S>) converter,
    required Widget Function({required P props}) builder,
  }) =>
      ValueListenableBuilder<P>(
        valueListenable: command.map((state) => converter(reducible)),
        builder: (_, props, ___) => builder(props: props),
      );
}

extension StoreOnBuildContext on BuildContext {
  ReducibleCommandStore<S> store<S>() =>
      InheritedValueWidget.of<ReducibleCommandStore<S>>(this);
}
