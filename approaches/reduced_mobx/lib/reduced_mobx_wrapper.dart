// mobx_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:reduced/inherited_value_widget.dart';
import 'package:reduced/reduced_typedefs.dart';

import 'reduced_mobx.dart';


Widget wrapWithProvider({
  required ReducibleStore store,
  required Widget child,
}) =>
    InheritedValueWidget(value: store, child: child);

extension WrapWithConsumer on ReducibleStore {
  Widget wrapWithConsumer<P>({
    required P Function(ReducibleStore) props,
    required PropsWidgetBuilder<P> builder,
  }) =>
      Observer(builder: (_) => builder(props: props(this)));
}
