// binder_adapter.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';

import 'package:reducible/reducible.dart';

import 'binder_reducible.dart';

Widget stateProviderAdapter({Key? key, required Widget child}) =>
    BinderScope(child: child);

extension StateConsumerAdapter<S> on ReducibleLogic<S> {
  Widget stateConsumerAdapter<P>({
    required StateRef<S> stateRef,
    required P Function(Reducible<S>) converter,
    required Widget Function({required P props}) builder,
  }) =>
      Consumer<P>(
        watchable: stateRef.select(
          (state) => converter(
            Reducible(() => state, reducible.reduce, this),
          ),
        ),
        builder: (_, __, ___) => builder(
          props: converter(reducible),
        ),
      );
}
