// redux_reduceable.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../reduceable.dart';

extension ReduceableStore on Store {
  Reduceable<S> reduceable<S>() => 
    Reduceable(() => state, (reducer) => dispatch(reducer), this);
}

Widget builderWidget<S, P>({
  required P Function(Reduceable<S>) converter,
  required Widget Function({Key? key, required P props}) builder,
}) =>
    StoreConnector<S, P>(
      converter: (store) => converter(store.reduceable<S>()),
      builder: (context, props) => builder(props: props),
    );
