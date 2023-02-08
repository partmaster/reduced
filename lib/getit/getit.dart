import 'package:flutter/foundation.dart';

import '../reduceable.dart';

extension ReduceableOnValueNotifier<S> on ValueNotifier<S> {
  S getState() => value;

  void reduce(Reducer<S> reducer) {
    value = reducer(value);
  }

  Reduceable<S> get reduceable =>
      Reduceable(getState, reduce);
}
