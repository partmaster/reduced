// redux_adapter.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reducible/reducible.dart';
import 'package:redux/redux.dart' hide Reducer;

import 'redux_reducible.dart';

Widget stateProviderAdapter<S>({
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

Widget stateConsumerAdapter<S, P>({
  required P Function(Reducible<S>) converter,
  required Widget Function({Key? key, required P props}) builder,
}) =>
    StoreConnector<S, P>(
      distinct: true,
      converter: (store) => converter(store.reducible<S>()),
      builder: (context, props) => builder(props: props),
    );
