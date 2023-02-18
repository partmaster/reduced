// fluttertriple_adapter.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:reducible/reducible.dart';

import '../../widget/stateful_inherited_value_widget.dart';
import 'fluttertriple_reducible.dart';

Widget injectStateProvider<S extends Object>({
  required S initialState,
  required Widget child,
}) =>
    StatefulInheritedValueWidget(
      builder: (initialState) => ReducibleStreamStore(initialState),
      initializer: initialState,
      child: child,
    );

extension InjectStateConsumer<S extends Object> on ReducibleStreamStore<S> {
  Widget injectStateConsumer<P>({
    required ReducibleConverter<S, P> converter,
    required Widget Function({required P props}) builder,
  }) =>
      ScopedBuilder<ReducibleStreamStore<S>, Object, S>(
        store: this,
        distinct: (_) => converter(reducible),
        onState: (_, __) => builder(props: converter(reducible)),
      );
}
