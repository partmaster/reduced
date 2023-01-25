import 'package:flutter_bloc/flutter_bloc.dart';

import '../model.dart';
import '../reduceable_state.dart';

class CounterBlocs extends Bloc<Reducer<MyAppState>, MyAppState> {
  CounterBlocs()
      : super(
          const MyAppState(title: 'title', counter: 0),
        ) {
    on<Reducer<MyAppState>>((event, emit) => emit(event(state)));
  }

  void reduce(Reducer<MyAppState> reducer) => add(reducer);
}

extension ReduceableStateOnCounterBlocs on CounterBlocs {
  ReduceableState<MyAppState> get reduceableState =>
      ReduceableState(state, reduce);
}
