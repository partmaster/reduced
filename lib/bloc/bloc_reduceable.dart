// bloc_reduceable.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../reduceable.dart';

class BlocReduceable<S> extends Bloc<Reducer<S>, S> {
  BlocReduceable(super.initialState) {
    on<Reducer<S>>((event, emit) => emit(event(state)));
  }

  S getState() => state;

  late final reduceable = Reduceable(getState, add, this);
}
