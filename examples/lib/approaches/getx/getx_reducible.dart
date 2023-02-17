// getx_reducible.dart

import 'package:get/get.dart';
import 'package:reducible/reducible.dart';

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
