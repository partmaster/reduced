// getx_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reduced/reduced_function_typedefs.dart';

import 'reduced_getx.dart';

Widget wrapWithProvider<S>({
  required S initialState,
  required Widget child,
}) {
  Get.put(ReducibleGetx(initialState));
  return child;
}

Widget wrapWithConsumer<S, P extends Object>({
  required ReducibleConverter<S, P> converter,
  required PropsWidgetBuilder<P> builder,
}) =>
    GetBuilder<ReducibleGetx<S>>(
      filter: (controller) => converter(controller.reducible),
      builder: (controller) => builder(props: converter(controller.reducible)),
    );
