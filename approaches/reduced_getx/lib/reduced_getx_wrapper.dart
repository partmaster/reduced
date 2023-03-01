// getx_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reduced/functions.dart';

import 'reduced_getx.dart';

void registerState<S>({required S initialState}) =>
    Get.put(ReducibleGetx(initialState));

Widget wrapWithConsumer<S, P extends Object>({
  required ReducibleTransformer<S, P> transformer,
  required PropsWidgetBuilder<P> builder,
}) =>
    GetBuilder<ReducibleGetx<S>>(
      filter: (controller) => transformer(controller.reducible),
      builder: (controller) =>
          builder(props: transformer(controller.reducible)),
    );
