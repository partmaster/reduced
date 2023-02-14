// fluttercommands_reduceable.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_command/flutter_command.dart';

import '../../reduceable.dart';

class ReduceableCommandStore<S> {
  ReduceableCommandStore(S initialState) : _state = initialState;

  S _state;

  late final command = Command.createSync((Reducer<S> reducer) {
    _state = reducer(_state);
    return _state;
  }, _state);

  late final Reduceable<S> reduceable =
      Reduceable(() => _state, command, this);
}

Widget createValueListenableBuilder<S, P>({
  required ReduceableCommandStore<S> store,
  required P Function(Reduceable<S>) converter,
  required Widget Function({required P props}) builder,
}) =>
    ValueListenableBuilder<P>(
      valueListenable: store.command.map(
        (state) => converter(store.reduceable),
      ),
      builder: (_, props, ___) => builder(props: props),
    );
