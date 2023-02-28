// getx_reducible.dart

library reduced_getx;

import 'package:get/get.dart';
import 'package:reduced/reduced.dart';

class ReducibleGetx<S> extends GetxController implements Reducible<S> {
  ReducibleGetx(S state) : _state = state;

  S _state;

  @override
  S get state => _state;

  @override
  void reduce(Reducer<S> reducer) {
    _state = reducer(_state);
    update();
  }

  late final Reducible<S> reducible = this;
}
