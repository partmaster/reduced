// bloc_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reducible/reducible.dart';

class ReducibleBloc<S> extends Bloc<Reducer<S>, S> {
  ReducibleBloc(super.initialState) {
    on<Reducer<S>>((event, emit) => emit(event(state)));
  }

  S getState() => state;

  late final reducible = Reducible(getState, add, this);
}

extension ExtensionBlocOnBuildContext on BuildContext {
  ReducibleBloc<S> bloc<S>() => BlocProvider.of<ReducibleBloc<S>>(this);
}
