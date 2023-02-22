// reduced_redux.dart

library reduced_redux;

import 'package:reduced/reduced.dart';
import 'package:redux/redux.dart' hide Reducer;

extension ReducibleStore on Store {
  Reducible<S> reducible<S>() =>
      ReducibleProxy(() => state, (reducer) => dispatch(reducer), this);
}
