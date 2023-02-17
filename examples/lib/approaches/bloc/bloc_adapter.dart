// bloc_adapter.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reducible/reducible.dart';

import 'bloc_reducible.dart';

Widget stateProviderAdapter<S>(
        {required S initialState, required Widget child}) =>
    BlocProvider(
      create: (_) => ReducibleBloc(initialState),
      child: child,
    );

extension StateConsumerAdapter<S> on ReducibleBloc<S> {
  Widget stateConsumerAdapter<P>({
    required P Function(Reducible<S>) converter,
    required Widget Function({required P props}) builder,
  }) =>
      BlocSelector<ReducibleBloc<S>, S, P>(
        selector: (state) => converter(reducible),
        builder: (context, props) => builder(props: props),
      );
}
