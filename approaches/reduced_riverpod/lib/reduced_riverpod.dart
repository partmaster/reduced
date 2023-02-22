// reduced_riverpod.dart

library reduced_riverpod;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reduced/reduced.dart';

class ReducibleStateNotifier<S> extends StateNotifier<S> {
  ReducibleStateNotifier(super.state);

  late final reducible = ReducibleProxy(getState, reduce, this);

  S getState() => super.state;

  void reduce(Reducer<S> reducer) => state = reducer(state);
}
