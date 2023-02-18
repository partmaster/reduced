// fluttertriple_injector.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../typedefs.dart';
import '../../widget/stateful_inherited_value_widget.dart';
import 'fluttertriple_reducible.dart';

Widget wrapWithProvider<S extends Object>({
  required S initialState,
  required Widget child,
}) =>
    StatefulInheritedValueWidget(
      builder: (initialState) => ReducibleStreamStore(initialState),
      initializer: initialState,
      child: child,
    );

extension WrapWithConsumer<S extends Object> on ReducibleStreamStore<S> {
  Widget wrapWithConsumer<P>({
    required ReducibleConverter<S, P> converter,
    required PropsWidgetBuilder<P> builder,
  }) =>
      ScopedBuilder<ReducibleStreamStore<S>, Object, S>(
        store: this,
        distinct: (_) => converter(reducible),
        onState: (_, __) => builder(props: converter(reducible)),
      );
}
