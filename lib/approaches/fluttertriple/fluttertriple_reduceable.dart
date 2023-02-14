// fluttertriple_reduceable.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../reduceable.dart';

class ReduceableStreamStore<S extends Object> extends StreamStore<Object, S> {
  ReduceableStreamStore(super.initialState);

  S getState() => state;

  void reduce(Reducer<S> reducer) => update(reducer(state));

  late final Reduceable<S> reduceable =
      Reduceable(getState, reduce, this);
}

Widget scopedBuilder<S extends Object, P>({
  required ReduceableStreamStore<S> store,
  required P Function(Reduceable<S>) converter,
  required Widget Function({required P props}) builder,
}) =>
    ScopedBuilder<ReduceableStreamStore<S>, Object, S>(
      store: store,
      distinct: (_) => converter(store.reduceable),
      onState: (_, __) => builder(props: converter(store.reduceable)),
    );
