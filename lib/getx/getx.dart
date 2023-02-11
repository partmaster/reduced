import 'package:get/get.dart';

import '../reduceable.dart';

class AppStateController<S> extends GetxController {
  AppStateController(S state) : _state = state;

  S _state;

  S getState() => _state;

  void reduce(Reducer<S> reducer) {
    _state = reducer(_state);
    update();
  }

  Reduceable<S> get reduceable =>
      Reduceable(getState, reduce);
}
