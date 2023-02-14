// fluttertriple_reduceable.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../inherited_value_widget.dart';
import '../../reduceable.dart';

class ReduceableStreamStore<S extends Object>
    extends StreamStore<Object, S> {
  ReduceableStreamStore(super.initialState);

  S getState() => state;

  void reduce(Reducer<S> reducer) => update(reducer(state));

  late final Reduceable<S> reduceable =
      Reduceable(getState, reduce, this);
}

extension BuildWidgetExtension<S extends Object>
    on ReduceableStreamStore<S> {
  Widget buildWidget<P>({
    required P Function(Reduceable<S>) converter,
    required Widget Function({required P props}) builder,
  }) =>
      ScopedBuilder<ReduceableStreamStore<S>, Object, S>(
        store: this,
        distinct: (_) => converter(reduceable),
        onState: (_, __) => builder(props: converter(reduceable)),
      );
}

extension StoreOnBuildContext on BuildContext {
  ReduceableStreamStore<S> store<S extends Object>() =>
      InheritedValueWidget.of<ReduceableStreamStore<S>>(this);
}
