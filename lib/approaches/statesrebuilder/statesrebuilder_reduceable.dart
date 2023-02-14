// statesrebuilder_reduceable.dart

import 'package:flutter/foundation.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../reduceable.dart';

typedef StateToPropsConverter<S, P> = P Function(Reduceable<S>);

@immutable
class Store<S> {
  Store(S intitialValue) : value = RM.inject<S>(() => intitialValue);

  final Injected<S> value;

  S getState() => value.state;

  void reduce(Reducer<S> reducer) =>
      value.state = reducer(value.state);

  late final Reduceable<S> reduceable =
      Reduceable(getState, reduce, this);
}

P stateToProps<S, P>(
  S state,
  Reduce<S> reduce,
  StateToPropsConverter<S, P> converter,
) =>
    converter(Reduceable(() => state, reduce, reduce));

bool shouldRebuild<S, P>(
  S p0,
  S p1,
  Reduce<S> reduce,
  StateToPropsConverter<S, P> converter,
) =>
    stateToProps(p0, reduce, converter) !=
    stateToProps(p1, reduce, converter);
