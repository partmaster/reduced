// bloc_injector.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reduced/functions.dart';

import 'reduced_bloc.dart';

Widget wrapWithProvider<S>({
  required S initialState,
  required Widget child,
}) =>
    BlocProvider(
      create: (_) => ReducibleBloc(initialState),
      child: child,
    );

extension WrapWithConsumer<S> on ReducibleBloc<S> {
  Widget wrapWithConsumer<P>({
    required ReducibleTransformer<S, P> transformer,
    required PropsWidgetBuilder<P> builder,
  }) =>
      BlocSelector<ReducibleBloc<S>, S, P>(
        selector: (state) {
          final result = transformer(reducible);
          print('selector => $result');
          return result;
        },
        builder: (context, props) => builder(props: props),
      );
}
