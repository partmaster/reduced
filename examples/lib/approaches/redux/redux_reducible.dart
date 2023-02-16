// redux_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reduceable/reducible.dart';
import 'package:redux/redux.dart' hide Reducer;

extension ReducibleStore on Store {
  Reducible<S> reducible<S>() =>
      Reducible(() => state, (reducer) => dispatch(reducer), this);
}

Widget binderWidget<S>({
  required S initialState,
  required Widget child,
}) =>
    StoreProvider(
        store: Store(
          (state, action) =>
              action is Reducer ? action(state) : state,
          initialState: initialState,
        ),
        child: child);

Widget builderWidget<S, P>({
  required P Function(Reducible<S>) converter,
  required Widget Function({Key? key, required P props}) builder,
}) =>
    StoreConnector<S, P>(
      distinct: true,
      converter: (store) => converter(store.reducible<S>()),
      builder: (context, props) => builder(props: props),
    );
