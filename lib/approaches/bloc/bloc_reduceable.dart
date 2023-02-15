// bloc_reduceable.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../reduceable.dart';

class ReduceableBloc<S> extends Bloc<Reducer<S>, S> {
  ReduceableBloc(super.initialState) {
    on<Reducer<S>>((event, emit) => emit(event(state)));
  }

  S getState() => state;

  late final reduceable = Reduceable(getState, add, this);
}

Widget binderWidget<S>(
        {required S initialState, required Widget child}) =>
    BlocProvider(
      create: (_) => ReduceableBloc(initialState),
      child: child,
    );

extension BuilderWidgetExtension<S> on ReduceableBloc<S> {
  Widget builderWidget<P>({
    required P Function(Reduceable<S>) converter,
    required Widget Function({required P props}) builder,
  }) =>
      BlocSelector<ReduceableBloc<S>, S, P>(
        selector: (state) => converter(reduceable),
        builder: (context, props) => builder(props: props),
      );
}

extension BlocOnBuildContext on BuildContext {
  ReduceableBloc<S> bloc<S>() =>
      BlocProvider.of<ReduceableBloc<S>>(this);
}
