// bloc_reduceable.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../reduceable.dart';

class ReduceableBloc<S> extends Bloc<Reducer<S>, S> {
  ReduceableBloc(super.initialState) {
    on<Reducer<S>>((event, emit) => emit(event(state)));
  }

  S getState() => state;

  late final reduceable = Reduceable(getState, add, this);
}
