// getx_reduceable.dart

import 'package:get/get.dart';

import '../reduceable.dart';

class ReduceableGetx<S> extends GetxController {
  ReduceableGetx(S state) : _state = state;

  S _state;

  S getState() => _state;

  void reduce(Reducer<S> reducer) {
    _state = reducer(_state);
    update();
  }

  late final Reduceable<S> reduceable =
      Reduceable(getState, reduce, this);
}
