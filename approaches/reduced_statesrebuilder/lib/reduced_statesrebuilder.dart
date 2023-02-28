// reduced_statesrebuilder.dart

library reduced_statesrebuilder;

import 'package:flutter/widgets.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:reduced/reduced.dart';
import 'package:inherited_widgets/inherited_widgets.dart';

@immutable
class Store<S> {
  Store(S intitialValue) : value = RM.inject<S>(() => intitialValue);

  final Injected<S> value;

  S getState() => value.state;

  void reduce(Reducer<S> reducer) => value.state = reducer(value.state);

  late final Reducible<S> reducible = ReducibleProxy(getState, reduce, this);
}

extension ExtensionStoreOnBuildContext on BuildContext {
  Store<S> store<S>() => InheritedValueWidget.of<Store<S>>(this);
}
