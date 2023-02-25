// fluttercommand_reducible.dart

library reduced_fluttercommand;

import 'package:flutter/widgets.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:reduced/reduced.dart';
import 'package:inherited_widgets/inherited_widgets.dart';

class ReducibleCommandStore<S> extends Reducible<S> {
  ReducibleCommandStore(S initialState) : _state = initialState;

  S _state;

  @override
  get state => _state;

  @override
  S reduce(Reducer<S> reducer) {
    _state = reducer(_state);
    return _state;
  }

  late final command = Command.createSync(reduce, _state);

  late final Reducible<S> reducible = this;
}

extension ExtensionStoreOnBuildContext on BuildContext {
  ReducibleCommandStore<S> store<S>() =>
      InheritedValueWidget.of<ReducibleCommandStore<S>>(this);
}
