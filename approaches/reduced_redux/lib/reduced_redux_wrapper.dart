// redux_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced/reduced_function_typedefs.dart';
import 'package:redux/redux.dart' hide Reducer;

import 'reduced_redux.dart';

Widget wrapWithProvider<S>({
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

Widget wrapWithConsumer<S, P>({
  required ReducibleConverter<S, P> converter,
  required PropsWidgetBuilder<P> builder,
}) =>
    StoreConnector<S, P>(
      distinct: true,
      converter: (store) => converter(store.reducible<S>()),
      builder: (context, props) => builder(props: props),
    );
