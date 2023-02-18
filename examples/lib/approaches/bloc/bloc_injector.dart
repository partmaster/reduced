// bloc_adapter.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../typedefs.dart';
import 'bloc_reducible.dart';

Widget injectStateProvider<S>(
        {required S initialState, required Widget child}) =>
    BlocProvider(
      create: (_) => ReducibleBloc(initialState),
      child: child,
    );

extension InjectStateConsumer<S> on ReducibleBloc<S> {
  Widget injectStateConsumer<P>({
    required ReducibleConverter<S, P> converter,
    required PropsWidgetBuilder<P> builder,
  }) =>
      BlocSelector<ReducibleBloc<S>, S, P>(
        selector: (state) => converter(reducible),
        builder: (context, props) => builder(props: props),
      );
}
