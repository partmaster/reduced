// binder_wrapper.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced/reduced_function_typedefs.dart';

import 'reduced_binder.dart';

Widget wrapWithProvider({required Widget child}) =>
    BinderScope(child: child);

extension WrapWithConsumer<S> on ReducibleLogic<S> {
  Widget wrapWithConsumer<P>({
    required StateRef<S> stateRef,
    required ReducibleConverter<S, P> converter,
    required PropsWidgetBuilder<P> builder,
  }) =>
      Consumer<P>(
        watchable: stateRef.select(
          (state) => converter(
            ReducibleProxy(() => state, reducible.reduce, this),
          ),
        ),
        builder: (_, __, ___) => builder(
          props: converter(reducible),
        ),
      );
}
