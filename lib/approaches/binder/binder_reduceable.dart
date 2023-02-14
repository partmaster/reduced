// binder_reduceable.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';

import '../../reduceable.dart';

export 'package:binder/src/build_context_extensions.dart';

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

Consumer<P> createConsumer<S, P>({
  required StateRef<S> stateRef,
  required ReduceableLogic<S> logic,
  required P Function(Reduceable<S>) converter,
  required Widget Function({required P props}) builder,
}) =>
    Consumer<P>(
      watchable: stateRef.select(
        (state) => converter(
          Reduceable(() => state, logic.reduceable.reduce, logic),
        ),
      ),
      builder: (_, __, ___) => builder(
        props: converter(logic.reduceable),
      ),
    );
