// reduced_bloc.dart

library reduced_bloc;

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reduced/reduced.dart';

class ReducibleBloc<S> extends Bloc<Reducer<S>, S> {
  ReducibleBloc(super.initialState) {
    on<Reducer<S>>((event, emit) => emit(event(state)));
  }

  S getState() => state;

  late final reducible = ReducibleProxy(getState, add, this);
}

extension ExtensionBlocOnBuildContext on BuildContext {
  ReducibleBloc<S> bloc<S>() =>
      BlocProvider.of<ReducibleBloc<S>>(this);
}
