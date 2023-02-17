// getx_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reducible/reducible.dart';

import 'getx_reducible.dart';

Widget stateProviderAdapter<S>({
  required S initialState,
  required Widget child,
}) {
  Get.put(ReducibleGetx(initialState));
  return child;
}

Widget stateConsumerAdapter<S, P extends Object>({
  required P Function(Reducible<S>) converter,
  required Widget Function({Key? key, required P props}) builder,
}) =>
    GetBuilder<ReducibleGetx<S>>(
      filter: (controller) => converter(controller.reducible),
      builder: (controller) => builder(props: converter(controller.reducible)),
    );
