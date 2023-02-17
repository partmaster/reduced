// fluttertriple_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:reducible/reducible.dart';

import '../../widget/inherited_value_widget.dart';

class ReducibleStreamStore<S extends Object>
    extends StreamStore<Object, S> {
  ReducibleStreamStore(super.initialState);

  S getState() => state;

  void reduce(Reducer<S> reducer) => update(reducer(state));

  late final Reducible<S> reducible =
      Reducible(getState, reduce, this);
}

extension StoreOnBuildContext on BuildContext {
  ReducibleStreamStore<S> store<S extends Object>() =>
      InheritedValueWidget.of<ReducibleStreamStore<S>>(this);
}
