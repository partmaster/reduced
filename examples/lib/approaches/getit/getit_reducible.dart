// getit_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:reducible/reducible.dart';

extension ReducibleValueNotifier<S> on ValueNotifier<S> {
  S getState() => value;

  void reduce(Reducer<S> reducer) {
    value = reducer(value);
  }

  Reducible<S> get reducible => Reducible(getState, reduce, this);
}
