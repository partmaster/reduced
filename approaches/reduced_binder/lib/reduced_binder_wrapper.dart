// binder_wrapper.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced/functions.dart';

import 'reduced_binder.dart';

typedef ReducibleScope = BinderScope;

/// Wraps the given child with a ReducibleScope.
Widget wrapWithScope({required Widget child}) =>
    ReducibleScope(child: child);

extension WrapWithConsumer<S> on ReducibleLogic<S> {
  /// Builds a widget with the given builder and wraps it with a Consumer.
  Widget wrapWithConsumer<P>({
    required StateRef<S> stateRef,
    required ReducibleTransformer<S, P> transformer,
    required PropsWidgetBuilder<P> builder,
  }) =>
      Consumer<P>(
        watchable: stateRef.select(
          (state) => transformer(
            ReducibleProxy(() => state, reducible.reduce, this),
          ),
        ),
        builder: (_, __, ___) => builder(
          props: transformer(reducible),
        ),
      );
}
