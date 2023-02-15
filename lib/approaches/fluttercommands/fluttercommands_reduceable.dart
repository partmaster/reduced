// fluttercommands_reduceable.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_command/flutter_command.dart';

import '../../inherited_value_widget.dart';
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

extension BuildWidgetExtension<S> on ReduceableCommandStore<S> {
  Widget buildWidget<P>({
    required P Function(Reduceable<S>) converter,
    required Widget Function({required P props}) builder,
  }) =>
      ValueListenableBuilder<P>(
        valueListenable:
            command.map((state) => converter(reduceable)),
        builder: (_, props, ___) => builder(props: props),
      );
}

extension StoreOnBuildContext on BuildContext {
  ReduceableCommandStore<S> store<S>() =>
      InheritedValueWidget.of<ReduceableCommandStore<S>>(this);
}
