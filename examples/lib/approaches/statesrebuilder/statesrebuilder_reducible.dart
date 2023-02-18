// statesrebuilder_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:reducible/reducible.dart';

import '../../widget/inherited_value_widget.dart';

@immutable
class Store<S> {
  Store(S intitialValue) : value = RM.inject<S>(() => intitialValue);

  final Injected<S> value;

  S getState() => value.state;

  void reduce(Reducer<S> reducer) =>
      value.state = reducer(value.state);

  late final Reducible<S> reducible =
      Reducible(getState, reduce, this);
}

extension ExtensionStoreOnBuildContext on BuildContext {
  Store<S> store<S>() => InheritedValueWidget.of<Store<S>>(this);
}
