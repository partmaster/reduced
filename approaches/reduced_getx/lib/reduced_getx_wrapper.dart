// getx_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reduced/reduced_functions.dart';

import 'reduced_getx.dart';

Widget wrapWithProvider<S>({
  required S initialState,
  required Widget child,
}) {
  Get.put(ReducibleGetx(initialState));
  return child;
}

Widget wrapWithConsumer<S, P extends Object>({
  required ReducibleTransformer<S, P> transformer,
  required PropsWidgetBuilder<P> builder,
}) =>
    GetBuilder<ReducibleGetx<S>>(
      filter: (controller) => transformer(controller.reducible),
      builder: (controller) => builder(props: transformer(controller.reducible)),
    );
