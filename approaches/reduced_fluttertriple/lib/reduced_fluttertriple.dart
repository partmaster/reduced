// reduced_fluttertriple.dart

library reduced_fluttertriple;

import 'package:flutter/widgets.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:inherited_widgets/inherited_widgets.dart';
import 'package:reduced/reduced.dart';

class ReducibleStreamStore<S extends Object> extends StreamStore<Object, S>
    implements Reducible<S> {
  ReducibleStreamStore(super.initialState);

  @override
  void reduce(Reducer<S> reducer) => update(reducer(state));

  late final Reducible<S> reducible = this;
}

extension ExtensionStoreOnBuildContext on BuildContext {
  ReducibleStreamStore<S> store<S extends Object>() =>
      InheritedValueWidget.of<ReducibleStreamStore<S>>(this);
}
