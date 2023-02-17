// redux_reducible.dart

import 'package:reducible/reducible.dart';
import 'package:redux/redux.dart' hide Reducer;

extension ReducibleStore on Store {
  Reducible<S> reducible<S>() =>
      Reducible(() => state, (reducer) => dispatch(reducer), this);
}
