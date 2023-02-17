// solidart_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:reducible/reducible.dart';

extension ReducibleSignal<S> on Signal<S> {
  S getState() => value;

  void reduce(Reducer<S> reducer) => value = reducer(value);

  Reducible<S> get reducible => Reducible(getState, reduce, this);
}

extension StoreOnBuildContext on BuildContext {
  Signal<S> store<S>() => get<Signal<S>>(S);
}
