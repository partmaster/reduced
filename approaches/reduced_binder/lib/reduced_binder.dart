// reduced_binder.dart

// library reduced_binder;

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';
// ignore: implementation_imports
import 'package:binder/src/build_context_extensions.dart';
import 'package:reduced/reduced.dart';

class ReducibleLogic<S> with Logic {
  ReducibleLogic(this.scope, this.state);

  final StateRef<S> state;

  @override
  final Scope scope;

  S getState() => read(state);

  void reduce(Reducer<S> reducer) => write(
        state,
        reducer(getState()),
      );

  late final Reducible<S> reducible =
      Reducible(getState, reduce, this);
}

extension ExtensionLogicOnBuildContext on BuildContext {
  ReducibleLogic<S> logic<S>(LogicRef<ReducibleLogic<S>> ref) =>
      readScope().use(ref);
}
