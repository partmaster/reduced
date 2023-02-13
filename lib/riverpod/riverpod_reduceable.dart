// riverpod_reduceable.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../reduceable.dart';

class ReduceableStateNotifier<S> extends StateNotifier<S> {
  ReduceableStateNotifier(super.state);

  late final reduceable = Reduceable(getState, reduce, this);

  S getState() => super.state;

  void reduce(Reducer<S> reducer) => state = reducer(state);
}

