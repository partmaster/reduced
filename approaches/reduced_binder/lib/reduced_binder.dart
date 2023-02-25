// reduced_binder.dart

library reduced_binder;

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';
// ignore: implementation_imports
import 'package:binder/src/build_context_extensions.dart';
import 'package:reduced/reduced.dart';

class ReducibleLogic<S> extends Reducible<S> with Logic {
  ReducibleLogic(this.scope, this.ref);

  final StateRef<S> ref;

  @override
  final Scope scope;

  @override
  S get state => read(ref);

  @override
  void reduce(Reducer<S> reducer) => write(
        ref,
        reducer(state),
      );

  late final Reducible<S> reducible = this;
}

extension ExtensionLogicOnBuildContext on BuildContext {
  ReducibleLogic<S> logic<S>(LogicRef<ReducibleLogic<S>> ref) =>
      readScope().use(ref);
}
