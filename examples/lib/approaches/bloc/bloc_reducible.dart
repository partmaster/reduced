// bloc_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reduceable/reducible.dart';

class ReducibleBloc<S> extends Bloc<Reducer<S>, S> {
  ReducibleBloc(super.initialState) {
    on<Reducer<S>>((event, emit) => emit(event(state)));
  }

  S getState() => state;

  late final reducible = Reducible(getState, add, this);
}

Widget binderWidget<S>({required S initialState, required Widget child}) =>
    BlocProvider(
      create: (_) => ReducibleBloc(initialState),
      child: child,
    );

extension BuilderWidgetExtension<S> on ReducibleBloc<S> {
  Widget builderWidget<P>({
    required P Function(Reducible<S>) converter,
    required Widget Function({required P props}) builder,
  }) =>
      BlocSelector<ReducibleBloc<S>, S, P>(
        selector: (state) => converter(reducible),
        builder: (context, props) => builder(props: props),
      );
}

extension BlocOnBuildContext on BuildContext {
  ReducibleBloc<S> bloc<S>() => BlocProvider.of<ReducibleBloc<S>>(this);
}
