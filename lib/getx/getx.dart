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

  late final Reduceable<S> reduceable =
      Reduceable(getState, reduce, this);
}
