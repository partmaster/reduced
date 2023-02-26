// reduced_riverpod.dart

library reduced_riverpod;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reduced/reduced.dart';

class ReducibleStateNotifier<S> extends StateNotifier<S>
    implements Reducible<S> {
  ReducibleStateNotifier(super.state);

  late final Reducible<S> reducible = this;

  @override
  reduce(reducer) => state = reducer(state);
}
