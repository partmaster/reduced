// binder_reducible.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';
// ignore: implementation_imports
import 'package:binder/src/build_context_extensions.dart';
import 'package:reducible/reducible.dart';

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

Widget binderWidget({Key? key, required Widget child}) =>
    BinderScope(child: child);

extension BuilderWidgetExtension<S> on ReducibleLogic<S> {
  Widget builderWidget<P>({
    required StateRef<S> stateRef,
    required P Function(Reducible<S>) converter,
    required Widget Function({required P props}) builder,
  }) =>
      Consumer<P>(
        watchable: stateRef.select(
          (state) => converter(
            Reducible(() => state, reducible.reduce, this),
          ),
        ),
        builder: (_, __, ___) => builder(
          props: converter(reducible),
        ),
      );
}

extension LogicOnBuildContext on BuildContext {
  ReducibleLogic<S> logic<S>(LogicRef<ReducibleLogic<S>> ref) =>
      readScope().use(ref);
}
