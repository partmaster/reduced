// getx_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reduceable/reducible.dart';

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

Widget binderWidget<S>({
  required S initialState,
  required Widget child,
}) {
  Get.put(ReducibleGetx(initialState));
  return child;
}

Widget builderWidget<S, P extends Object>({
  required P Function(Reducible<S>) converter,
  required Widget Function({Key? key, required P props}) builder,
}) =>
    GetBuilder<ReducibleGetx<S>>(
      filter: (controller) =>
          converter(controller.reducible),
      builder: (controller) =>
          builder(props: converter(controller.reducible)),
    );
