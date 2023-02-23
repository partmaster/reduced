// mobx_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:inherited_widgets/inherited_widgets.dart';
import 'package:reduced/reduced_functions.dart';

import 'reduced_mobx.dart';

Widget wrapWithProvider<S, P1, P2>({
  required S initialState,
  required ReducibleTransformer<S, P1> transformer1,
  required ReducibleTransformer<S, P2> transformer2,
  required Widget child,
}) =>
    StatefulInheritedValueWidget(
      builder: (initialState) => ReducibleStore(
        initialState,
        transformer1,
        transformer2,
      ),
      initializer: initialState,
      child: child,
    );

extension WrapWithConsumer on ReducibleStore {
  Widget wrapWithConsumer<P>({
    required P Function(ReducibleStore) props,
    required PropsWidgetBuilder<P> builder,
  }) =>
      Observer(builder: (_) => builder(props: props(this)));
}
