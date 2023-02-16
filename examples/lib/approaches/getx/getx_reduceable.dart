// getx_reduceable.dart

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reduceable/reduceable.dart';

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

Widget binderWidget<S>({
  required S initialState,
  required Widget child,
}) {
  Get.put(ReduceableGetx(initialState));
  return child;
}

Widget builderWidget<S, P extends Object>({
  required P Function(Reduceable<S>) converter,
  required Widget Function({Key? key, required P props}) builder,
}) =>
    GetBuilder<ReduceableGetx<S>>(
      filter: (controller) =>
          converter(controller.reduceable),
      builder: (controller) =>
          builder(props: converter(controller.reduceable)),
    );
