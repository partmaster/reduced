// getx_reducible.dart

library reduced_getx;

import 'package:get/get.dart';
import 'package:reduced/reduced.dart';

class ReducibleGetx<S> extends GetxController {
  ReducibleGetx(S state) : _state = state;

  S _state;

  S getState() => _state;

  void reduce(Reducer<S> reducer) {
    _state = reducer(_state);
    update();
  }

  late final Reducible<S> reducible =
      Reducible(getState, reduce, this);
}
