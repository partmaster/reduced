// redux_reduceable.dart

import 'package:redux/redux.dart';

import '../../reduceable.dart';

extension ReduceableStore on Store {
  Reduceable<S> reduceable<S>() => 
    Reduceable(() => state, (reducer) => dispatch(reducer), this);
}
