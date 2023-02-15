// binder_reduceable.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';

import '../../reduceable.dart';

import 'package:binder/src/build_context_extensions.dart';

class ReduceableLogic<S> with Logic {
  ReduceableLogic(this.scope, this.state);

  final StateRef<S> state;

  @override
  final Scope scope;

  S getState() => read(state);

  void reduce(Reducer<S> reducer) => write(
        state,
        reducer(getState()),
      );

  late final Reduceable<S> reduceable =
      Reduceable(getState, reduce, this);
}

extension BuilderWidgetExtension<S> on ReduceableLogic<S> {
  Widget builderWidget<P>({
    required StateRef<S> stateRef,
    required P Function(Reduceable<S>) converter,
    required Widget Function({required P props}) builder,
  }) =>
      Consumer<P>(
        watchable: stateRef.select(
          (state) => converter(
            Reduceable(() => state, reduceable.reduce, this),
          ),
        ),
        builder: (_, __, ___) => builder(
          props: converter(reduceable),
        ),
      );
}

extension LogicOnBuildContext on BuildContext {
  ReduceableLogic<S> logic<S>(LogicRef<ReduceableLogic<S>> ref) =>
      readScope().use(ref);
}
