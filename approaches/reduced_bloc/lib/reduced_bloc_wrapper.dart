// bloc_injector.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reduced/reduced_typedefs.dart';

import 'reduced_bloc.dart';

Widget wrapWithProvider<S>(
        {required S initialState, required Widget child}) =>
    BlocProvider(
      create: (_) => ReducibleBloc(initialState),
      child: child,
    );

extension WrapWithConsumer<S> on ReducibleBloc<S> {
  Widget wrapWithConsumer<P>({
    required ReducibleConverter<S, P> converter,
    required PropsWidgetBuilder<P> builder,
  }) =>
      BlocSelector<ReducibleBloc<S>, S, P>(
        selector: (state) => converter(reducible),
        builder: (context, props) => builder(props: props),
      );
}
