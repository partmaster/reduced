// fluttertriple_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:reduceable/reducible.dart';

import '../../util/inherited_value_widget.dart';
import '../../util/stateful_inherited_value_widget.dart';

class ReducibleStreamStore<S extends Object>
    extends StreamStore<Object, S> {
  ReducibleStreamStore(super.initialState);

  S getState() => state;

  void reduce(Reducer<S> reducer) => update(reducer(state));

  late final Reducible<S> reducible =
      Reducible(getState, reduce, this);
}

Widget binderWidget<S extends Object>({
  required S initialState,
  required Widget child,
}) =>
    StatefulInheritedValueWidget(
      builder: (initialState) => ReducibleStreamStore(initialState),
      initializer: initialState,
      child: child,
    );

extension BuilderWidgetExtension<S extends Object>
    on ReducibleStreamStore<S> {
  Widget builderWidget<P>({
    required P Function(Reducible<S>) converter,
    required Widget Function({required P props}) builder,
  }) =>
      ScopedBuilder<ReducibleStreamStore<S>, Object, S>(
        store: this,
        distinct: (_) => converter(reducible),
        onState: (_, __) => builder(props: converter(reducible)),
      );
}

extension StoreOnBuildContext on BuildContext {
  ReducibleStreamStore<S> store<S extends Object>() =>
      InheritedValueWidget.of<ReducibleStreamStore<S>>(this);
}
