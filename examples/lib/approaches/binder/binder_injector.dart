// binder_injector.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';

import 'package:reducible/reducible.dart';

import '../../typedefs.dart';
import 'binder_reducible.dart';

Widget injectStateProvider({Key? key, required Widget child}) =>
    BinderScope(child: child);

extension InjectStateConsumer<S> on ReducibleLogic<S> {
  Widget injectStateConsumer<P>({
    required StateRef<S> stateRef,
    required ReducibleConverter<S, P> converter,
    required PropsWidgetBuilder<P> builder,
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
