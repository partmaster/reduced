// mobx_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:inherited_widgets/inherited_widgets.dart';
import 'package:reduced/reduced_function_typedefs.dart';

import 'reduced_mobx.dart';

Widget wrapWithProvider<S, P1, P2>({
  required S initialState,
  required ReducibleConverter<S, P1> converter1,
  required ReducibleConverter<S, P2> converter2,
  required Widget child,
}) =>
    StatefulInheritedValueWidget(
      builder: (initialState) => ReducibleStore(
        initialState,
        converter1,
        converter2,
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
