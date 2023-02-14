// fluttertriple_reduceable.dart

import 'package:flutter_triple/flutter_triple.dart';

import '../../reduceable.dart';

class ReduceableStreamStore<S extends Object> extends StreamStore<Object, S> {
  ReduceableStreamStore(super.initialState);

  S getState() => state;

  void reduce(Reducer<S> reducer) => update(reducer(state));

  late final Reduceable<S> reduceable =
      Reduceable(getState, reduce, this);
}

