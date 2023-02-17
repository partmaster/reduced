// riverpod_reducible.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reducible/reducible.dart';

class ReducibleStateNotifier<S> extends StateNotifier<S> {
  ReducibleStateNotifier(super.state);

  late final reducible = Reducible(getState, reduce, this);

  S getState() => super.state;

  void reduce(Reducer<S> reducer) => state = reducer(state);
}
