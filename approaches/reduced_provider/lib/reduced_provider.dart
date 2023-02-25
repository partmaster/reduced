// reduced_provider.dart

library reduced_provider;

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

extension ReducibleValueNotifier<S> on ValueNotifier<S> {
  S getState() => value;

  void reduce(Reducer<S> reducer) => value = reducer(value);

  Reducible<S> get reducible =>
      ReducibleProxy(getState, reduce, this);
}
